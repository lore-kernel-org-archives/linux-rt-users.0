From: "Bruce Ashfield" <bruce.ashfield@windriver.com>
Subject: Re: rc4-rt1: powerpc compile errors
Date: Mon, 3 Sep 2007 11:10:23 -0300
Message-ID: <3bd6b93c0709030710o21cab1b5y9c8438c40c53560e@mail.gmail.com>
References: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
To: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:24023 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbXICOKZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Sep 2007 10:10:25 -0400
Received: by wr-out-0506.google.com with SMTP id 36so683860wra
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Sep 2007 07:10:24 -0700 (PDT)
In-Reply-To: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/3/07, Pradyumna Sampath <pradyumna.sampath@gmail.com> wrote:
> Hi everyone,
>
> Here are some compile errors from the latest -rt patchset for powerpc
> (mpc5200).
>
> arch/powerpc/kernel/entry_32.S: Assembler messages:
> arch/powerpc/kernel/entry_32.S:231: Error: operand out of range
> (0x00023d87 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:644: Error: operand out of range
> (0x00022006 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:866: Error: operand out of range
> (0x00020004 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:880: Error: operand out of range
> (0x00020004 is not between 0x00000000 and 0x0000ffff)
>
> Im not sure whether this is the right thing to do but we got around
> this by replacing the linux/include/asm-powerpc/thread_info.h with an
> older version of the same file from 2.6.21-rt3.

I don't have the code in front of me, but you can also shuffle
the flags to make sure that macro being used in entry_32.S
has all the flags within 16 bits (so the immediate operations
will successfully assemble). That's the route I took. The flags
have expanded past that threshold just recently.

Bruce


>
> regards
> /prady
>
> --
> htp://prady.livejournal.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
