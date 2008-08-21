From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Thu, 21 Aug 2008 15:16:04 +0200
Message-ID: <520f0cf10808210616s1d7d66fcpbddf6904c9c70870@mail.gmail.com>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
	 <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_56227_1013979.1219324564297"
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: "Gilles Carry" <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbYHUNQG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 09:16:06 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1026666ugf.37
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Aug 2008 06:16:04 -0700 (PDT)
In-Reply-To: <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

------=_Part_56227_1013979.1219324564297
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Aug 18, 2008 at 4:42 PM, Gilles Carry <gilles.carry@bull.net> wrote:
> This patch makes hrtimers initialized with hrtimer_init_sleeper
> to use another mode and then not be stuck in waitqueues when
> hrtimer_interrupt is very busy.
>
> The new mode is HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
> The above-mentionned timers have been moved from
> HRTIMER_CB_IRQSAFE_NO_SOFTIRQ to
> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
>
> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ timers use a slightly different
> state machine from HRTIMER_CB_IRQSAFE_NO_SOFTIRQ's as when removing the
> timer, __run_hrtimer sets the status to INACTIVE _then_
> wakes up the thread. This way, an awakened thread cannot enter
> hrtimer_cancel before the timer's status has changed.
>
> Signed-off-by: Gilles Carry <gilles.carry@bull.net>
>
> ---
>  include/linux/hrtimer.h |    4 ++++
>  kernel/hrtimer.c        |   26 +++++++++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> index f3867fd..53f4d44 100644
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -49,12 +49,16 @@ enum hrtimer_restart {
>  *                                     does not restart the timer
>  *     HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:  Callback must run in hardirq context
>  *                                     Special mode for tick emultation
> + *     HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
> + *                                     Callback must run in hardirq context and
> + *                                     does not restart the timer
>  */
>  enum hrtimer_cb_mode {
>        HRTIMER_CB_SOFTIRQ,
>        HRTIMER_CB_IRQSAFE,
>        HRTIMER_CB_IRQSAFE_NO_RESTART,
>        HRTIMER_CB_IRQSAFE_NO_SOFTIRQ,
> +       HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ,
>  };
>
>  /*
> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> index fa63a24..778eb7e 100644
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
> @@ -668,6 +668,7 @@ static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
>                /* Timer is expired, act upon the callback mode */
>                switch(timer->cb_mode) {
>                case HRTIMER_CB_IRQSAFE_NO_RESTART:
> +               case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
>                        debug_hrtimer_deactivate(timer);
>                        /*
>                         * We can call the callback from here. No restart
> @@ -1089,6 +1090,8 @@ int hrtimer_cancel(struct hrtimer *timer)
>
>                if (ret >= 0)
>                        return ret;
> +               WARN_ON (timer->cb_mode ==

Minor point here, we may as well squash checkpatch.pl complaints now,
to reduce any clean-up later to push to mainline. if you run
checkpatch.pl
WARNING: space prohibited between function name and open parenthesis '('
#69: FILE: kernel/hrtimer.c:1093:
+               WARN_ON (timer->cb_mode ==


> +                       HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ);
>                hrtimer_wait_for_timer(timer);
>        }
>  }
> @@ -1298,11 +1301,18 @@ static void __run_hrtimer(struct hrtimer *timer)
>        int restart;
>
>        debug_hrtimer_deactivate(timer);
> -       __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
> -       timer_stats_account_hrtimer(timer);
>
>        fn = timer->function;
> -       if (timer->cb_mode == HRTIMER_CB_IRQSAFE_NO_SOFTIRQ) {
> +
> +       switch (timer->cb_mode) {
> +       case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
> +               __remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);

Correct me if I'm wrong but there is a lot of code reworking and code
expansion here, when really the above line is the only difference
between your new HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ
and HRTIMER_CB_IRQSAFE_NO_SOFTIRQ.
It is not even strictly necessary to return, since the rest of the
function should be safe. I have attached an alternate smaller patch, -
maybe you'll find it simpler?


> +               timer_stats_account_hrtimer(timer);
> +               spin_unlock(&cpu_base->lock);
> +               fn(timer);
> +               spin_lock(&cpu_base->lock);
> +               return;
> +       case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
>                /*
>                 * Used for scheduler timers, avoid lock inversion with
>                 * rq->lock and tasklist_lock.
> @@ -1310,11 +1320,17 @@ static void __run_hrtimer(struct hrtimer *timer)
>                 * These timers are required to deal with enqueue expiry
>                 * themselves and are not allowed to migrate.
>                 */
> +               __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
> +               timer_stats_account_hrtimer(timer);
>                spin_unlock(&cpu_base->lock);
>                restart = fn(timer);
>                spin_lock(&cpu_base->lock);
> -       } else
> +               break;
> +       default:
> +               __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
> +               timer_stats_account_hrtimer(timer);
>                restart = fn(timer);
> +       }
>
>        /*
>         * Note: We clear the CALLBACK bit after enqueue_hrtimer to avoid
> @@ -1516,7 +1532,7 @@ void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
>        sl->timer.function = hrtimer_wakeup;
>        sl->task = task;
>  #ifdef CONFIG_HIGH_RES_TIMERS
> -       sl->timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_SOFTIRQ;
> +       sl->timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ;
>  #endif
>  }
>
> --
> 1.5.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_Part_56227_1013979.1219324564297
Content-Type: text/x-patch; name=hrtimers_stuck_in_waitq-jk.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fk5eawsq0
Content-Disposition: attachment; filename=hrtimers_stuck_in_waitq-jk.patch

RnJvbTogZ2lsbGVzLmNhcnJ5QGJ1bGwubmV0IEdpbGxlcyBDYXJyeSAKVG86IGxpbnV4LXJ0LXVz
ZXJzQHZnZXIua2VybmVsLm9yZyAKRGF0ZTogTW9uLCAxOCBBdWcgMjAwOCAxNjo0MjozMSArMDIw
MCAKU3ViamVjdDogW1BBVENIIDEvMl0gW1JUXSBocnRpbWVycyBzdHVjayBpbiB3YWl0cXVldWUg
CiAKVGhpcyBwYXRjaCBtYWtlcyBocnRpbWVycyBpbml0aWFsaXplZCB3aXRoIGhydGltZXJfaW5p
dF9zbGVlcGVyCnRvIHVzZSBhbm90aGVyIG1vZGUgYW5kIHRoZW4gbm90IGJlIHN0dWNrIGluIHdh
aXRxdWV1ZXMgd2hlbgpocnRpbWVyX2ludGVycnVwdCBpcyB2ZXJ5IGJ1c3kuCgpUaGUgbmV3IG1v
ZGUgaXMgSFJUSU1FUl9DQl9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09GSVJRLgpUaGUgYWJvdmUt
bWVudGlvbm5lZCB0aW1lcnMgaGF2ZSBiZWVuIG1vdmVkIGZyb20KSFJUSU1FUl9DQl9JUlFTQUZF
X05PX1NPRlRJUlEgdG8KSFJUSU1FUl9DQl9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09GSVJRLgoK
SFJUSU1FUl9DQl9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09GSVJRIHRpbWVycyB1c2UgYSBzbGln
aHRseSBkaWZmZXJlbnQKc3RhdGUgbWFjaGluZSBmcm9tIEhSVElNRVJfQ0JfSVJRU0FGRV9OT19T
T0ZUSVJRJ3MgYXMgd2hlbiByZW1vdmluZyB0aGUKdGltZXIsIF9fcnVuX2hydGltZXIgc2V0cyB0
aGUgc3RhdHVzIHRvIElOQUNUSVZFIF90aGVuXwp3YWtlcyB1cCB0aGUgdGhyZWFkLiBUaGlzIHdh
eSwgYW4gYXdha2VuZWQgdGhyZWFkIGNhbm5vdCBlbnRlcgpocnRpbWVyX2NhbmNlbCBiZWZvcmUg
dGhlIHRpbWVyJ3Mgc3RhdHVzIGhhcyBjaGFuZ2VkLgoKU2lnbmVkLW9mZi1ieTogR2lsbGVzIENh
cnJ5IDxnaWxsZXMuY2FycnlAYnVsbC5uZXQ+Ci1yZXdvcmtlZCB0aGUgcGF0Y2ggdG8gcmVkdWNl
IGl0J3Mgc2l6ZSBhbmQgbW9yZSBjbG9zZWx5IG1hdGNoIHRoZSBvcmlnaW5hbCBmdW5jdGlvbi4K
LSByZW1vdmVkIHNwYWNlIGFmdGVyIFdBUk5fT04gdG8gcmVtb3ZlIGNoZWNrcGF0Y2gucGwgd2Fy
bmluZy4KU2lnbmVkLW9mZi1ieTogSm9obiBLYWN1ciA8amthY3VyIGF0IGdtYWlsIGRvdCBjb20+
CgotLS0KIGluY2x1ZGUvbGludXgvaHJ0aW1lci5oIHwgICAgNCArKysrCiBrZXJuZWwvaHJ0aW1l
ci5jICAgICAgICB8ICAgMjYgKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYu
MjYuMi1ydDEtamsvaW5jbHVkZS9saW51eC9ocnRpbWVyLmgKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
Mi42LjI2LjItcnQxLWprLm9yaWcvaW5jbHVkZS9saW51eC9ocnRpbWVyLmgKKysrIGxpbnV4LTIu
Ni4yNi4yLXJ0MS1qay9pbmNsdWRlL2xpbnV4L2hydGltZXIuaApAQCAtNDksMTIgKzQ5LDE2IEBA
IGVudW0gaHJ0aW1lcl9yZXN0YXJ0IHsKICAqCQkJCQlkb2VzIG5vdCByZXN0YXJ0IHRoZSB0aW1l
cgogICoJSFJUSU1FUl9DQl9JUlFTQUZFX05PX1NPRlRJUlE6CUNhbGxiYWNrIG11c3QgcnVuIGlu
IGhhcmRpcnEgY29udGV4dAogICoJCQkJCVNwZWNpYWwgbW9kZSBmb3IgdGljayBlbXVsdGF0aW9u
CisgKglIUlRJTUVSX0NCX0lSUVNBRkVfTk9fUkVTVEFSVF9OT19TT0ZUSVJROgorICoJCQkJCUNh
bGxiYWNrIG11c3QgcnVuIGluIGhhcmRpcnEgY29udGV4dCBhbmQKKyAqCQkJCQlkb2VzIG5vdCBy
ZXN0YXJ0IHRoZSB0aW1lcgogICovCiBlbnVtIGhydGltZXJfY2JfbW9kZSB7CiAJSFJUSU1FUl9D
Ql9TT0ZUSVJRLAogCUhSVElNRVJfQ0JfSVJRU0FGRSwKIAlIUlRJTUVSX0NCX0lSUVNBRkVfTk9f
UkVTVEFSVCwKIAlIUlRJTUVSX0NCX0lSUVNBRkVfTk9fU09GVElSUSwKKwlIUlRJTUVSX0NCX0lS
UVNBRkVfTk9fUkVTVEFSVF9OT19TT0ZUSVJRLAogfTsKIAogLyoKSW5kZXg6IGxpbnV4LTIuNi4y
Ni4yLXJ0MS1qay9rZXJuZWwvaHJ0aW1lci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4yNi4y
LXJ0MS1qay5vcmlnL2tlcm5lbC9ocnRpbWVyLmMKKysrIGxpbnV4LTIuNi4yNi4yLXJ0MS1qay9r
ZXJuZWwvaHJ0aW1lci5jCkBAIC02NjgsNiArNjY4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgaHJ0
aW1lcl9lbnF1ZXVlX3JlcHJvZwogCQkvKiBUaW1lciBpcyBleHBpcmVkLCBhY3QgdXBvbiB0aGUg
Y2FsbGJhY2sgbW9kZSAqLwogCQlzd2l0Y2godGltZXItPmNiX21vZGUpIHsKIAkJY2FzZSBIUlRJ
TUVSX0NCX0lSUVNBRkVfTk9fUkVTVEFSVDoKKwkJY2FzZSBIUlRJTUVSX0NCX0lSUVNBRkVfTk9f
UkVTVEFSVF9OT19TT0ZUSVJROgogCQkJZGVidWdfaHJ0aW1lcl9kZWFjdGl2YXRlKHRpbWVyKTsK
IAkJCS8qCiAJCQkgKiBXZSBjYW4gY2FsbCB0aGUgY2FsbGJhY2sgZnJvbSBoZXJlLiBObyByZXN0
YXJ0CkBAIC0xMDg5LDYgKzEwOTAsOCBAQCBpbnQgaHJ0aW1lcl9jYW5jZWwoc3RydWN0IGhydGlt
ZXIgKnRpbWVyCiAKIAkJaWYgKHJldCA+PSAwKQogCQkJcmV0dXJuIHJldDsKKwkJV0FSTl9PTih0
aW1lci0+Y2JfbW9kZSA9PQorCQkJSFJUSU1FUl9DQl9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09G
VElSUSk7CiAJCWhydGltZXJfd2FpdF9mb3JfdGltZXIodGltZXIpOwogCX0KIH0KQEAgLTEyOTgs
MTEgKzEzMDEsMTUgQEAgc3RhdGljIHZvaWQgX19ydW5faHJ0aW1lcihzdHJ1Y3QgaHJ0aW1lcgog
CWludCByZXN0YXJ0OwogCiAJZGVidWdfaHJ0aW1lcl9kZWFjdGl2YXRlKHRpbWVyKTsKLQlfX3Jl
bW92ZV9ocnRpbWVyKHRpbWVyLCBiYXNlLCBIUlRJTUVSX1NUQVRFX0NBTExCQUNLLCAwKTsKKwlp
ZiAodGltZXItPmNiX21vZGUgPT0gSFJUSU1FUl9DQl9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09G
VElSUSkKKwkJX19yZW1vdmVfaHJ0aW1lcih0aW1lciwgYmFzZSwgSFJUSU1FUl9TVEFURV9JTkFD
VElWRSwgMCk7CisJZWxzZQorCQlfX3JlbW92ZV9ocnRpbWVyKHRpbWVyLCBiYXNlLCBIUlRJTUVS
X1NUQVRFX0NBTExCQUNLLCAwKTsKIAl0aW1lcl9zdGF0c19hY2NvdW50X2hydGltZXIodGltZXIp
OwogCiAJZm4gPSB0aW1lci0+ZnVuY3Rpb247Ci0JaWYgKHRpbWVyLT5jYl9tb2RlID09IEhSVElN
RVJfQ0JfSVJRU0FGRV9OT19TT0ZUSVJRKSB7CisKKwlpZiAodGltZXItPmNiX21vZGUgPT0gSFJU
SU1FUl9DQl9JUlFTQUZFX05PX1NPRlRJUlEgfHwgdGltZXItPmNiX21vZGUgPT0gSFJUSU1FUl9D
Ql9JUlFTQUZFX05PX1JFU1RBUlRfTk9fU09GVElSUSkgewogCQkvKgogCQkgKiBVc2VkIGZvciBz
Y2hlZHVsZXIgdGltZXJzLCBhdm9pZCBsb2NrIGludmVyc2lvbiB3aXRoCiAJCSAqIHJxLT5sb2Nr
IGFuZCB0YXNrbGlzdF9sb2NrLgpAQCAtMTUxNiw3ICsxNTIzLDcgQEAgdm9pZCBocnRpbWVyX2lu
aXRfc2xlZXBlcihzdHJ1Y3QgaHJ0aW1lcgogCXNsLT50aW1lci5mdW5jdGlvbiA9IGhydGltZXJf
d2FrZXVwOwogCXNsLT50YXNrID0gdGFzazsKICNpZmRlZiBDT05GSUdfSElHSF9SRVNfVElNRVJT
Ci0Jc2wtPnRpbWVyLmNiX21vZGUgPSBIUlRJTUVSX0NCX0lSUVNBRkVfTk9fU09GVElSUTsKKwlz
bC0+dGltZXIuY2JfbW9kZSA9IEhSVElNRVJfQ0JfSVJRU0FGRV9OT19SRVNUQVJUX05PX1NPRlRJ
UlE7CiAjZW5kaWYKIH0KIAo=
------=_Part_56227_1013979.1219324564297--
