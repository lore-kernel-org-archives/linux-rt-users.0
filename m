From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: v2.6.21.4-rt11
Date: Tue, 12 Jun 2007 06:00:10 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F50101D9F6@scsmsx415.amr.corp.intel.com>
References: <20070612073207.GA32646@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Dinakar Guniguntala" <dino@in.ibm.com>
To: "Ingo Molnar" <mingo@elte.hu>,
	"Eric St-Laurent" <ericstl34@sympatico.ca>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16277 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285AbXFLNA0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jun 2007 09:00:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070612073207.GA32646@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

 

>-----Original Message-----
>From: Ingo Molnar [mailto:mingo@elte.hu] 
>Sent: Tuesday, June 12, 2007 12:32 AM
>To: Eric St-Laurent
>Cc: linux-kernel@vger.kernel.org; 
>linux-rt-users@vger.kernel.org; Thomas Gleixner; Dinakar 
>Guniguntala; Pallipadi, Venkatesh
>Subject: Re: v2.6.21.4-rt11
>
>
>(Cc:-ed Venki for the force-hpet issue below)
>
>* Eric St-Laurent <ericstl34@sympatico.ca> wrote:
>
>> On Sat, 2007-09-06 at 23:05 +0200, Ingo Molnar wrote:
>> > i'm pleased to announce the v2.6.21.4-rt11 kernel, which can be 
>> > downloaded from the usual place:
>> 
>> I'm running 2.6.21.4-rt12-cfs-v17 (x86_64), so far no 
>problems. I like 
>> this kernel a lot, it's feels quite smooth.
>
>yeah, that's probably CFS in the works :-) That combined with 
>PREEMPT_RT 
>makes for a really snappy desktop.
>
>> One little thing, no HPET timer is detected. By looking at 
>the patch, 
>> even the force detect code is there, it should work.
>> 
>> The hpet timer is not available as a clocksource and only one hpet
>> related message is present in dmesg:
>> 
>> PM: Adding info for No Bus:hpet
>> 
>> This is on a Asus P5LD2-VM motherboard (ICH7)
>> 
>> Relevant config bits:
>> 
>> CONFIG_HPET_TIMER=y
>> # CONFIG_HPET_EMULATE_RTC is not set
>> CONFIG_HPET=y
>> # CONFIG_HPET_RTC_IRQ is not set
>> CONFIG_HPET_MMAP=y
>> 
>> Should I enable one of the two other options? Any ideas?
>
>Venki, is this ICH7 board supposed to work with force-hpet?
>

Yes. Force_hpet part is should have worked..
Eric: Can you send me the output of 'lspci -n on your system.
We need to double check we are covering all ICH7 ids.

Thanks,
Venki
