From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [RFC][PATCH] fix SCHED_FIFO spec violation (backport)
Date: Mon, 7 Jul 2008 13:00:49 +0200
Message-ID: <520f0cf10807070400l67c14367hff52f7b16c7ee757@mail.gmail.com>
References: <1215124898.11333.20.camel@Aeon>
	 <520f0cf10807040608w7e8cea01r39e2489269bc9f73@mail.gmail.com>
	 <1215271090.18491.20.camel@Aeon>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18441_28943078.1215428449831"
Cc: linux-rt-users@vger.kernel.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>,
	"Clark Williams" <williams@redhat.com>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>,
	"Gregory Haskins" <ghaskins@novell.com>
To: "Darren Hart" <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:34202 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYGGLAu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Jul 2008 07:00:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2625012rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Jul 2008 04:00:50 -0700 (PDT)
In-Reply-To: <1215271090.18491.20.camel@Aeon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

------=_Part_18441_28943078.1215428449831
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jul 5, 2008 at 5:18 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> On Fri, 2008-07-04 at 15:08 +0200, John Kacur wrote:
>> Since we're always being admonished to do code-review, and I needed to
>> waste some time, here are a few comments, to what looks largely like a
>> nice patch to me.
>
> Hi John, thanks for the review.  Note that this is a backport of Peter'z
> git patch, so I'll try to address some of your rationale questions
> below, but the short answer is "I tried to match Peter's implementation
> as closely as possible."  Regarding the patch applying, it worked for
> me... see below.
>
>>
>> On Fri, Jul 4, 2008 at 12:41 AM, Darren Hart <dvhltc@us.ibm.com> wrote:
>> > Enqueue deprioritized RT tasks to head of prio array
>> >
>> > This patch backports Peter Z's enqueue to head of prio array on
>> > de-prioritization to 2.6.24.7-rt14 which doesn't have the
>> > enqueue_rt_entity and associated changes.
>> >
>> > I've run several long running real-time java benchmarks and it's
>> > holding so far.  Steven, please consider this patch for inclusion
>> > in the next 2.6.24.7-rtX release.
>> >
>> > Peter, I didn't include your Signed-off-by as only about half your
>> > original patch applied to 2.6.24.7-r14.  If you're happy with this
>> > version, would you also sign off?
>> >
>> > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
>> >
>> >
>> > ---
>> > Index: linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
>> > ===================================================================
>> > --- linux-2.6.24.7-ibmrt2.6-view.orig/include/linux/sched.h
>> > +++ linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
>> > @@ -897,11 +897,16 @@ struct uts_namespace;
>> >  struct rq;
>> >  struct sched_domain;
>> >
>> > +#define ENQUEUE_WAKEUP 0x01
>> > +#define ENQUEUE_HEAD   0x02
>> > +
>> > +#define DEQUEUE_SLEEP  0x01
>> > +
>>
>> Question: is ENQUEUE_WAKEUP equal to DEQUEUE_SLEEP by design or
>> coincidence?
>
> Coincidence.  The ENQUEUE_* flags are only to be used with the
> enqueue_task* methods, while the DEQUEUE_* flags are for deqeue_task*.
> Note that the conversion of sleep to the DEQUEUE_SLEEP flag isn't really
> necessary as there is only the one flag, but it makes the calls
> parallel, which I suspect was Peter's intention (but I speculate here).
>
>> The renaming of wakeup and sleep to flags makes it at
>> least superficially seem like they overlap. Since a large part of the
>> patch is renaming, it might be easier to understand if the renaming
>> was done as a separate patch, but on the other hand, that is probably
>> just a PITA. :)
>
> Seems a small enough patch to be all in one to me.  If others object
> I'll split it out, but again, I tried to keep the backport as close to
> Peter's original patch as possible.
----SNIP-----
I'm not sure the renaming is necessary at all, since "wakeup" and
"sleep" seem more descriptive than "flags". If you skip the renaming
then the size of the patch is reduced to half it's current size.

>> Minor nit: was it necessary to create a new int, why not just flags &=
>> ENQUEUE_WAKEUP, plus subsequent renaming where necessary.
>>
>>
>
>
> Well... I've copied the entire function here for context:
>
> static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int
> flags)
> {
>        struct cfs_rq *cfs_rq;
>        struct sched_entity *se = &p->se;
>        int wakeup = flags & ENQUEUE_WAKEUP;
>
>        for_each_sched_entity(se) {
>                if (se->on_rq)
>                        break;
>                cfs_rq = cfs_rq_of(se);
>                enqueue_entity(cfs_rq, se, wakeup);
>                wakeup = 1;
>        }
> }
>
> Note that "wakeup = 1;" for all but the initial entity which uses the
> flag that was passed in.  So if this is correct behavior, then the new
> integer seems like a reasonable approach to me.  Note that the
> dequeue_task_fair has a parallel implementation.
>
> Peter, can you explain why only the first entity is subject to the value
> of the passed-in flags in these two functions.  I understand this was
> the orginal behavior as well.

I wonder if the only reason the extra int was created was just as a
quick way to deal with the renaming of the argument but not changing
the code in the function. If we skip the renmaing once again, then it
becomes slightly simpler.

Ok, so Peter Z did the hard work of creating the original patch, and
Darren Hart did the hard work of backporting it, I am doing the
relatively simple task of refractoring it, this reduces Darren's patch
in size by at least half. Maybe this alternate patch would be more
readily acceptable by Steve et al? OTOH Note that Darren extensively
tested his version of the patch, and I just did a compile and boot
test.

Including both and inlined and attachment until I can figure out how
to avoid line wrap in gmail.

Signed-off-by: John Kacur <jkacur@gmail.com>

Index: linux-2.6.24.7-rt14/include/linux/sched.h
===================================================================
--- linux-2.6.24.7-rt14.orig/include/linux/sched.h
+++ linux-2.6.24.7-rt14/include/linux/sched.h
@@ -897,6 +897,11 @@ struct uts_namespace;
 struct rq;
 struct sched_domain;

+#define ENQUEUE_WAKEUP	0x01
+#define ENQUEUE_HEAD	0x02
+
+#define DEQUEUE_SLEEP	0x01
+
 struct sched_class {
 	const struct sched_class *next;

Index: linux-2.6.24.7-rt14/kernel/sched.c
===================================================================
--- linux-2.6.24.7-rt14.orig/kernel/sched.c
+++ linux-2.6.24.7-rt14/kernel/sched.c
@@ -1759,7 +1759,7 @@ out_activate:
 	else
 		schedstat_inc(p, se.nr_wakeups_remote);
 	update_rq_clock(rq);
-	activate_task(rq, p, 1);
+	activate_task(rq, p, ENQUEUE_WAKEUP);
 	check_preempt_curr(rq, p);
 	success = 1;

@@ -3968,7 +3968,7 @@ asmlinkage void __sched __schedule(void)
 			prev->state = TASK_RUNNING;
 		} else {
 			touch_softlockup_watchdog();
-			deactivate_task(rq, prev, 1);
+			deactivate_task(rq, prev, DEQUEUE_SLEEP);
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -4431,7 +4431,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void task_setprio(struct task_struct *p, int prio)
 {
 	unsigned long flags;
-	int oldprio, prev_resched, on_rq, running;
+	int oldprio, prev_resched, on_rq, running, down;
 	struct rq *rq;
 	const struct sched_class *prev_class = p->sched_class;

@@ -4472,6 +4472,7 @@ void task_setprio(struct task_struct *p,
 	else
 		p->sched_class = &fair_sched_class;

+	down = (prio > p->prio) ? ENQUEUE_HEAD : 0;
 	p->prio = prio;

 //	trace_special_pid(p->pid, __PRIO(oldprio), PRIO(p));
@@ -4480,7 +4481,7 @@ void task_setprio(struct task_struct *p,
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq) {
-		enqueue_task(rq, p, 0);
+		enqueue_task(rq, p, down);
 		check_class_changed(rq, p, prev_class, oldprio, running);
 	}
 //	trace_special(prev_resched, _need_resched(), 0);
Index: linux-2.6.24.7-rt14/kernel/sched_fair.c
===================================================================
--- linux-2.6.24.7-rt14.orig/kernel/sched_fair.c
+++ linux-2.6.24.7-rt14/kernel/sched_fair.c
@@ -764,6 +764,7 @@ static void enqueue_task_fair(struct rq
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	wakeup &= ENQUEUE_WAKEUP;

 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -783,6 +784,7 @@ static void dequeue_task_fair(struct rq
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	sleep &= DEQUEUE_SLEEP;

 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
Index: linux-2.6.24.7-rt14/kernel/sched_rt.c
===================================================================
--- linux-2.6.24.7-rt14.orig/kernel/sched_rt.c
+++ linux-2.6.24.7-rt14/kernel/sched_rt.c
@@ -185,7 +185,11 @@ static void enqueue_task_rt(struct rq *r
 {
 	struct rt_prio_array *array = &rq->rt.active;

-	list_add_tail(&p->run_list, array->queue + p->prio);
+	if (unlikely(wakeup & ENQUEUE_HEAD))
+		list_add(&p->run_list, array->queue + p->prio);
+ 	else
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
 	__set_bit(p->prio, array->bitmap);
 	inc_rt_tasks(p, rq);

------=_Part_18441_28943078.1215428449831
Content-Type: text/x-patch; name=pandd.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ficyntin1
Content-Disposition: attachment; filename=pandd.patch

U2lnbmVkLW9mZi1ieTogSm9obiBLYWN1ciA8amthY3VyQGdtYWlsLmNvbT4KCkluZGV4OiBsaW51
eC0yLjYuMjQuNy1ydDE0L2luY2x1ZGUvbGludXgvc2NoZWQuaAo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51
eC0yLjYuMjQuNy1ydDE0Lm9yaWcvaW5jbHVkZS9saW51eC9zY2hlZC5oCisrKyBsaW51eC0yLjYu
MjQuNy1ydDE0L2luY2x1ZGUvbGludXgvc2NoZWQuaApAQCAtODk3LDYgKzg5NywxMSBAQCBzdHJ1
Y3QgdXRzX25hbWVzcGFjZTsKIHN0cnVjdCBycTsKIHN0cnVjdCBzY2hlZF9kb21haW47CiAKKyNk
ZWZpbmUgRU5RVUVVRV9XQUtFVVAJMHgwMQorI2RlZmluZSBFTlFVRVVFX0hFQUQJMHgwMgorCisj
ZGVmaW5lIERFUVVFVUVfU0xFRVAJMHgwMQorCiBzdHJ1Y3Qgc2NoZWRfY2xhc3MgewogCWNvbnN0
IHN0cnVjdCBzY2hlZF9jbGFzcyAqbmV4dDsKIApJbmRleDogbGludXgtMi42LjI0LjctcnQxNC9r
ZXJuZWwvc2NoZWQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMjQuNy1ydDE0Lm9yaWcva2Vy
bmVsL3NjaGVkLmMKKysrIGxpbnV4LTIuNi4yNC43LXJ0MTQva2VybmVsL3NjaGVkLmMKQEAgLTE3
NTksNyArMTc1OSw3IEBAIG91dF9hY3RpdmF0ZToKIAllbHNlCiAJCXNjaGVkc3RhdF9pbmMocCwg
c2UubnJfd2FrZXVwc19yZW1vdGUpOwogCXVwZGF0ZV9ycV9jbG9jayhycSk7Ci0JYWN0aXZhdGVf
dGFzayhycSwgcCwgMSk7CisJYWN0aXZhdGVfdGFzayhycSwgcCwgRU5RVUVVRV9XQUtFVVApOwog
CWNoZWNrX3ByZWVtcHRfY3VycihycSwgcCk7CiAJc3VjY2VzcyA9IDE7CiAKQEAgLTM5NjgsNyAr
Mzk2OCw3IEBAIGFzbWxpbmthZ2Ugdm9pZCBfX3NjaGVkIF9fc2NoZWR1bGUodm9pZCkKIAkJCXBy
ZXYtPnN0YXRlID0gVEFTS19SVU5OSU5HOwogCQl9IGVsc2UgewogCQkJdG91Y2hfc29mdGxvY2t1
cF93YXRjaGRvZygpOwotCQkJZGVhY3RpdmF0ZV90YXNrKHJxLCBwcmV2LCAxKTsKKwkJCWRlYWN0
aXZhdGVfdGFzayhycSwgcHJldiwgREVRVUVVRV9TTEVFUCk7CiAJCX0KIAkJc3dpdGNoX2NvdW50
ID0gJnByZXYtPm52Y3N3OwogCX0KQEAgLTQ0MzEsNyArNDQzMSw3IEBAIEVYUE9SVF9TWU1CT0wo
c2xlZXBfb25fdGltZW91dCk7CiB2b2lkIHRhc2tfc2V0cHJpbyhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIGludCBwcmlvKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Ci0JaW50IG9sZHByaW8sIHBy
ZXZfcmVzY2hlZCwgb25fcnEsIHJ1bm5pbmc7CisJaW50IG9sZHByaW8sIHByZXZfcmVzY2hlZCwg
b25fcnEsIHJ1bm5pbmcsIGRvd247CiAJc3RydWN0IHJxICpycTsKIAljb25zdCBzdHJ1Y3Qgc2No
ZWRfY2xhc3MgKnByZXZfY2xhc3MgPSBwLT5zY2hlZF9jbGFzczsKIApAQCAtNDQ3Miw2ICs0NDcy
LDcgQEAgdm9pZCB0YXNrX3NldHByaW8oc3RydWN0IHRhc2tfc3RydWN0ICpwLAogCWVsc2UKIAkJ
cC0+c2NoZWRfY2xhc3MgPSAmZmFpcl9zY2hlZF9jbGFzczsKIAorCWRvd24gPSAocHJpbyA+IHAt
PnByaW8pID8gRU5RVUVVRV9IRUFEIDogMDsKIAlwLT5wcmlvID0gcHJpbzsKIAogLy8JdHJhY2Vf
c3BlY2lhbF9waWQocC0+cGlkLCBfX1BSSU8ob2xkcHJpbyksIFBSSU8ocCkpOwpAQCAtNDQ4MCw3
ICs0NDgxLDcgQEAgdm9pZCB0YXNrX3NldHByaW8oc3RydWN0IHRhc2tfc3RydWN0ICpwLAogCWlm
IChydW5uaW5nKQogCQlwLT5zY2hlZF9jbGFzcy0+c2V0X2N1cnJfdGFzayhycSk7CiAJaWYgKG9u
X3JxKSB7Ci0JCWVucXVldWVfdGFzayhycSwgcCwgMCk7CisJCWVucXVldWVfdGFzayhycSwgcCwg
ZG93bik7CiAJCWNoZWNrX2NsYXNzX2NoYW5nZWQocnEsIHAsIHByZXZfY2xhc3MsIG9sZHByaW8s
IHJ1bm5pbmcpOwogCX0KIC8vCXRyYWNlX3NwZWNpYWwocHJldl9yZXNjaGVkLCBfbmVlZF9yZXNj
aGVkKCksIDApOwpJbmRleDogbGludXgtMi42LjI0LjctcnQxNC9rZXJuZWwvc2NoZWRfZmFpci5j
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4yNC43LXJ0MTQub3JpZy9rZXJuZWwvc2NoZWRfZmFp
ci5jCisrKyBsaW51eC0yLjYuMjQuNy1ydDE0L2tlcm5lbC9zY2hlZF9mYWlyLmMKQEAgLTc2NCw2
ICs3NjQsNyBAQCBzdGF0aWMgdm9pZCBlbnF1ZXVlX3Rhc2tfZmFpcihzdHJ1Y3QgcnEKIHsKIAlz
dHJ1Y3QgY2ZzX3JxICpjZnNfcnE7CiAJc3RydWN0IHNjaGVkX2VudGl0eSAqc2UgPSAmcC0+c2U7
CisJd2FrZXVwICY9IEVOUVVFVUVfV0FLRVVQOwogCiAJZm9yX2VhY2hfc2NoZWRfZW50aXR5KHNl
KSB7CiAJCWlmIChzZS0+b25fcnEpCkBAIC03ODMsNiArNzg0LDcgQEAgc3RhdGljIHZvaWQgZGVx
dWV1ZV90YXNrX2ZhaXIoc3RydWN0IHJxCiB7CiAJc3RydWN0IGNmc19ycSAqY2ZzX3JxOwogCXN0
cnVjdCBzY2hlZF9lbnRpdHkgKnNlID0gJnAtPnNlOworCXNsZWVwICY9IERFUVVFVUVfU0xFRVA7
CiAKIAlmb3JfZWFjaF9zY2hlZF9lbnRpdHkoc2UpIHsKIAkJY2ZzX3JxID0gY2ZzX3JxX29mKHNl
KTsKSW5kZXg6IGxpbnV4LTIuNi4yNC43LXJ0MTQva2VybmVsL3NjaGVkX3J0LmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42LjI0LjctcnQxNC5vcmlnL2tlcm5lbC9zY2hlZF9ydC5jCisrKyBsaW51
eC0yLjYuMjQuNy1ydDE0L2tlcm5lbC9zY2hlZF9ydC5jCkBAIC0xODUsNyArMTg1LDExIEBAIHN0
YXRpYyB2b2lkIGVucXVldWVfdGFza19ydChzdHJ1Y3QgcnEgKnIKIHsKIAlzdHJ1Y3QgcnRfcHJp
b19hcnJheSAqYXJyYXkgPSAmcnEtPnJ0LmFjdGl2ZTsKIAotCWxpc3RfYWRkX3RhaWwoJnAtPnJ1
bl9saXN0LCBhcnJheS0+cXVldWUgKyBwLT5wcmlvKTsKKwlpZiAodW5saWtlbHkod2FrZXVwICYg
RU5RVUVVRV9IRUFEKSkKKwkJbGlzdF9hZGQoJnAtPnJ1bl9saXN0LCBhcnJheS0+cXVldWUgKyBw
LT5wcmlvKTsKKyAJZWxzZQorCQlsaXN0X2FkZF90YWlsKCZwLT5ydW5fbGlzdCwgYXJyYXktPnF1
ZXVlICsgcC0+cHJpbyk7CisKIAlfX3NldF9iaXQocC0+cHJpbywgYXJyYXktPmJpdG1hcCk7CiAJ
aW5jX3J0X3Rhc2tzKHAsIHJxKTsKIAo=
------=_Part_18441_28943078.1215428449831--
