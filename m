From: Chuck Harding <charding@llnl.gov>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Tue, 6 Feb 2007 11:38:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702061136340.659@ghostwheel.llnl.gov>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nspiron-2.llnl.gov ([128.115.41.82]:44024 "EHLO
	nspiron-2.llnl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbXBFTuk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Feb 2007 14:50:40 -0500
In-Reply-To: <20070205065636.GA1652@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 5 Feb 2007, Ingo Molnar wrote:

> i have released the v2.6.20-rt1 kernel, which can be downloaded from the
> usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/

I find no patch-2.6.20-rt1 there. Is it somewhere else, perhaps?

>
> more info about the -rt patchset can be found in the RT wiki:
>
>  http://rt.wiki.kernel.org
>
> This is a fixes-only release. Since the -rt tree has been closely
> tracking Linus' upstream kernel since -rc1, no new issues are expected -
> please re-report if anything is still unfixed.
>
> There are lots of changes relative to 2.6.19-rt6 (the last stable
> release), but these are mostly fixes and other gradual improvements. KVM
> is now enabled in the yum kernel on both i686 and x86_64 (and has been
> enabled since around -rc1-rt1), the -rt tree tracks kvm-trunk (which is
> a bit fresher than upstream KVM) and has a few additional paravirt
> speedups implemented and enabled.
>
> to build a 2.6.20-rt1 tree, the following patches should be applied:
>
>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.20.tar.bz2
>  http://redhat.com/~mingo/realtime-preempt/patch-2.6.20-rt1
>
> the -rt YUM repository for Fedora Core 6 and 5, for architectures i686
> and x86_64 can be activated via:
>
>   cd /etc/yum.repos.d
>   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
>
>   yum install kernel-rt.x86_64   # on x86_64
>   yum install kernel-rt          # on i686
>
>   yum update kernel-rt           # refresh - or enable yum-updatesd
>
> as usual, bugreports, fixes and suggestions are welcome,
>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Charles D. (Chuck) Harding   <charding@llnl.gov>    Voice: 925-423-8879
Senior Computer Associate      LC Operations          Fax: 925-423-6961
B453 R2253/2131  Pager: 00500  Ops Room: 925-422-3743 Ops: 925-422-0484
Lawrence Livermore National Laboratory          Computation Directorate
Livermore, CA USA    http://www.llnl.gov    GPG Public Key ID: B9EB6601
-------------------- http://tinyurl.com/5w5ey -------------------------
-- Support bacteria - it's the only culture some people have! --
