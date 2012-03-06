From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RT 04/25][RFC 3.0.23-rt39-rc1] revert-seqlock-remove-unused-functions
Date: Tue, 6 Mar 2012 23:39:28 +0100
Message-ID: <CAONaPpFnn1EDh-NbJ5=iKw9q4N41KGVfKqJeO0NXvyTLjpzr4w@mail.gmail.com>
References: <20120306161636.491172179@goodmis.org>
	<20120306161945.770871645@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39709 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031250Ab2CFWja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 17:39:30 -0500
In-Reply-To: <20120306161945.770871645@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 6, 2012 at 5:16 PM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> revert: seqlock-remove-unused-functions.patch
>
> Revert:
>
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date: =A0 Sat Jul 16 18:38:22 2011 +0200
>
> =A0 =A0seqlock-remove-unused-functions.patch
>
> =A0 =A0Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> =A0include/linux/seqlock.h | =A0 21 +++++++++++++++++++++
> =A01 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index b990f6e..c6db9fb 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -69,6 +69,17 @@ static inline void write_sequnlock(seqlock_t *sl)
> =A0 =A0 =A0 =A0spin_unlock(&sl->lock);
> =A0}
>
> +static inline int write_tryseqlock(seqlock_t *sl)
> +{
> + =A0 =A0 =A0 int ret =3D spin_trylock(&sl->lock);
> +
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++sl->sequence;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_wmb();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* Start of read calculation -- fetch last complete writer token *=
/
> =A0static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
> =A0{
> @@ -237,4 +248,14 @@ static inline void write_seqcount_barrier(seqcou=
nt_t *s)
> =A0#define write_sequnlock_bh(lock) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0do { write_sequnlock(lock); local_bh_enable(); } while=
(0)
>
> +#define read_seqbegin_irqsave(lock, flags) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 ({ local_irq_save(flags); =A0 read_seqbegin(lock); })
> +
> +#define read_seqretry_irqrestore(lock, iv, flags) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D read_seqretry(lock, iv); =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_restore(flags); =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 })
> +
> =A0#endif /* __LINUX_SEQLOCK_H */
> --

Does this really need to be reverted? I don't believe the other
reverts make use of these functions either. Looking upstream ,they are
also not used here, so the original patch should be pushed upstream if
anything.

Thanks

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
