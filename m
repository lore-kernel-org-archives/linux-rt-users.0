From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [RT] seqlocks: use of PICK_FUNCTION breaks kernel compile when CONFIG_GENERIC_TIME is NOT set
Date: Wed, 17 Oct 2007 16:07:10 +0200
Message-ID: <3efb10970710170707g669aaadej85a997e6a6efa560@mail.gmail.com>
References: <3efb10970710160135q31fd3982h17fa23768960186d@mail.gmail.com>
	 <1192553566.17527.114.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: "Daniel Walker" <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:22574 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758869AbXJQOHN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 10:07:13 -0400
Received: by rn-out-0102.google.com with SMTP id i6so308675rng
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Oct 2007 07:07:12 -0700 (PDT)
In-Reply-To: <1192553566.17527.114.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Daniel,

> Here's another fix for this. I compile tested for ARM (!GENERIC_TIME) ,
> but I didn't boot test .. Could you boot test this patch?

This fix seems to work! The target still boots properly. So, it can be
pushed upstream... :-)

Kind Regards,

Remy Bohmer

2007/10/16, Daniel Walker <dwalker@mvista.com>:
> On Tue, 2007-10-16 at 10:35 +0200, Remy Bohmer wrote:
> > Hello Daniel and Ingo,
> >
> > I use 2.6.23-rt1 and the patch of Daniel below which seems to be in
> > there breaks the compilation of the RT-kernel when CONFIG_GENERIC_TIME
> > is NOT set.
> >
> > It breaks in the do_gettimeofday(struct timeval *tv) code in the
> > architecture specific code
> > where there is a call to: seq = read_seqbegin_irqsave(&xtime_lock, flags);
> > The PICK_FUNCTION implementation does not return anything, so the
> > compile breaks here.
> >
> > I am figuring out how to solve this problem nicely, but I have not
> > found a nice solution yet. Attached I have put my hack to make it
> > compile on ARM again, but maybe one of you can do a better proposal to
> > fix this.
>
> Here's another fix for this. I compile tested for ARM (!GENERIC_TIME) ,
> but I didn't boot test .. Could you boot test this patch?
>
> ---
>
> Move the read_seqbegin() call up in the chain so the value
> can be returned
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
>
> ---
>  include/linux/seqlock.h |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> Index: linux-2.6.23/include/linux/seqlock.h
> ===================================================================
> --- linux-2.6.23.orig/include/linux/seqlock.h
> +++ linux-2.6.23/include/linux/seqlock.h
> @@ -285,21 +285,20 @@ unsigned long __read_seqbegin_irqsave_ra
>         unsigned long flags;
>
>         local_irq_save(flags);
> -       __read_seqbegin_raw(sl);
>         return flags;
>  }
>
>  static __always_inline unsigned long __read_seqbegin_irqsave(seqlock_t *sl)
>  {
> -       __read_seqbegin(sl);
>         return 0;
>  }
>
>  #define read_seqbegin_irqsave(lock, flags)                     \
> -do {                                                           \
> +({                                                             \
>         flags = PICK_SEQ_OP_RET(__read_seqbegin_irqsave_raw,    \
>                 __read_seqbegin_irqsave, lock);                 \
> -} while (0)
> +       read_seqbegin(lock);                                    \
> +})
>
>  static __always_inline int
>  __read_seqretry_irqrestore(seqlock_t *sl, unsigned iv, unsigned long flags)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
