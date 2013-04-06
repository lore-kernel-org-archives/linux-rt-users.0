From: "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: malloc/free and priority inheritance?
Date: Sat, 06 Apr 2013 10:24:02 -0400
Message-ID: <51603002.1020501@redhat.com>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org> <515D808C.8090808@meduna.org> <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com> <515D93F8.5050006@redhat.com> <CAAHN_R2zdvYwQL_Md8C=+O9w3tc2y+XR5tofv3FEe6CjcOubAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
	libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423006Ab3DFOZe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 6 Apr 2013 10:25:34 -0400
In-Reply-To: <CAAHN_R2zdvYwQL_Md8C=+O9w3tc2y+XR5tofv3FEe6CjcOubAQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/04/2013 11:32 AM, Siddhesh Poyarekar wrote:
> On 4 April 2013 20:23, Carlos O'Donell <carlos@redhat.com> wrote:
>> ... and ARM uses the generic C code.
>>
>> My comments in BZ#12114 still remain. Why can't we make malloc/free
>> use PI locks? We need not convert lll_lock, but just make malloc-machine.h
>> use a PI-aware lock?
> 
> The trouble (as always) is to decide on when to use PI-aware locks.
> Do we do that by default or do we have (*chuckle*) an environment
> variable to override the default locks?  Maybe this discussion is more
> suitable for libc-alpha though, since we can hopefully get all
> maintainers to chime in there.

The number of tunables just keeps growing doesn't it?

Added this to my list of tunables in the WIP document I'm writing:
sourceware.org/glibc/wiki/TuningLibraryRuntimeBehavior

Cheers,
Carlos.

