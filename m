From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Tue, 06 Feb 2007 14:08:27 -0600
Message-ID: <45C8E03B.2020307@cybsft.com>
References: <20070205065636.GA1652@elte.hu> <Pine.LNX.4.64.0702061136340.659@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
To: Chuck Harding <charding@llnl.gov>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay00.pair.com ([209.68.5.9]:2933 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965416AbXBFUPL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Feb 2007 15:15:11 -0500
In-Reply-To: <Pine.LNX.4.64.0702061136340.659@ghostwheel.llnl.gov>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Chuck Harding wrote:
> On Mon, 5 Feb 2007, Ingo Molnar wrote:
> 
>> i have released the v2.6.20-rt1 kernel, which can be downloaded from the
>> usual place:
>>
>>  http://redhat.com/~mingo/realtime-preempt/
> 
> I find no patch-2.6.20-rt1 there. Is it somewhere else, perhaps?
> 
rt1 is now in older:
http://people.redhat.com/mingo/realtime-preempt/older/patch-2.6.20-rt1

However, looks like Ingo is up to rt4 now but there is no rt4 patch,
only RPMs? Ingo?

>>
>> more info about the -rt patchset can be found in the RT wiki:
>>
>>  http://rt.wiki.kernel.org
>>
>> This is a fixes-only release. Since the -rt tree has been closely
>> tracking Linus' upstream kernel since -rc1, no new issues are expected -
>> please re-report if anything is still unfixed.
>>
>> There are lots of changes relative to 2.6.19-rt6 (the last stable
>> release), but these are mostly fixes and other gradual improvements. KVM
>> is now enabled in the yum kernel on both i686 and x86_64 (and has been
>> enabled since around -rc1-rt1), the -rt tree tracks kvm-trunk (which is
>> a bit fresher than upstream KVM) and has a few additional paravirt
>> speedups implemented and enabled.
>>
>> to build a 2.6.20-rt1 tree, the following patches should be applied:
>>
>>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.20.tar.bz2
>>  http://redhat.com/~mingo/realtime-preempt/patch-2.6.20-rt1
>>
>> the -rt YUM repository for Fedora Core 6 and 5, for architectures i686
>> and x86_64 can be activated via:
>>
>>   cd /etc/yum.repos.d
>>   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
>>
>>   yum install kernel-rt.x86_64   # on x86_64
>>   yum install kernel-rt          # on i686
>>
>>   yum update kernel-rt           # refresh - or enable yum-updatesd
>>
>> as usual, bugreports, fixes and suggestions are welcome,
>>
>>     Ingo
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 


-- 
   kr
