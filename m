From: "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 04 Apr 2013 10:53:44 -0400
Message-ID: <515D93F8.5050006@redhat.com>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org> <515D808C.8090808@meduna.org> <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
	libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22817 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762207Ab3DDOx7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 10:53:59 -0400
In-Reply-To: <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/04/2013 09:37 AM, Siddhesh Poyarekar wrote:
> On 4 April 2013 19:00, Stanislav Meduna <stano@meduna.org> wrote:
> 
>> hm well.. the assembler version of e.g. __pthread_cond_broadcast
>> in 2.17 for x86 seems to be using the PI. No luck with ARM (2.16
>> in ports) though.
> 
> The generic C code was updated to use PI in current master (I don't
> remember if the arm support bits were added, but they must have been
> by now), so you could cherry-pick and backport those bits for your
> distro if you want.

... and ARM uses the generic C code.

My comments in BZ#12114 still remain. Why can't we make malloc/free
use PI locks? We need not convert lll_lock, but just make malloc-machine.h
use a PI-aware lock?

Cheers,
Carlos.

[1] http://sourceware.org/bugzilla/show_bug.cgi?id=12114
