From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Celinux-dev] Rt-preempt testing best practices
Date: Wed, 16 May 2007 09:24:59 -0500
Message-ID: <464B143B.7060505@cybsft.com>
References: <464A4FC4.6030606@am.sony.com> <Pine.LNX.4.60.0705160511090.649@rtl14.hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tim Bird <tim.bird@am.sony.com>,
	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
	linux-rt-users@vger.kernel.org, RTWG@LIST.CELINUXFORUM.ORG
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay03.pair.com ([209.68.5.17]:4534 "HELO relay03.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754605AbXEPObm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 10:31:42 -0400
In-Reply-To: <Pine.LNX.4.60.0705160511090.649@rtl14.hofr.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Nicholas Mc Guire wrote:
> 
>> I'm writing to tell you about a project I'm working on.
>> I'm trying to collect as much information as I can about
>> testing real time performance of Linux.
> 
>> I've started a wiki page at:
>> http://tree.celinuxforum.org/CelfPubWiki/RealtimeTestingBestPractices
>> (which is on CELF's wiki)
> 
> The tests noted in the LKML post on this page are very problematic, ping
> -f is not testing RT at all, it keeps the kernel in a very small active
> page set thus reducing page related penalties, the while loop using dd
> is also not too helpfull as it will de-facto run only in memory and cause
> absolutely no disk/mass-storage related interaction (try the same with
> mount -o remount,sync /  first and it will be devastating ! (limited to
> ext2/ext3/ufs))
> 
> The big problem with RT tests published is that they are all looking at
> the good case, they are loading the system but assuming successfull
> operations. The worst cases pup up when you run in the error paths of
> the kernel - then a trivial application can induce very large jitter in
> the system (run crashme in the background and rerun the tests...)
> 
> Also lmbench can give a statistic view of things (and not even that very
> precisely in some case i.e. context switch measurements are flawed) so
> this is not of much help for descision makers which variant to use - it
> does not help if the average performance is good but the mobile phone or
> mp3 klicks at 1s intervales "deterministically" - so I guess RT
> benchmarks need a notion of usage-profile to be of value.
> 
> 
>> However, I think this material would be better placed
>> on the Linux RT wiki at: http://rt.wiki.kernel.org/index.php/Main_Page
>> Does anyone have any problem with me moving the content to there,
>> and continuing my attempt to document this on that site?
> 
> 
> Note that this page is dedicated to RT-preempt and will most likely not
> cover the other variants of RT Linux availabe - so it might well be a
> good idea to maintain an independant page but cross-link them ?
> 
>> Note that there's some duplication of content with other
>> pages on the RT wiki.  I'll try to clean this up during the move.
> 
>> Any comments or suggestions are welcome.
> 
>> If you have done RT testing, and especially if you have published
>> information I can look at (and link to), please contact me.
> 
> There are a number of publications related to both benchmarking and
> analysis of hardware related artefacts (cache,BTB,TLB,etc.) which were
> published at the real-time Linux Workshops - should I collect them
> together and send you those as tar.bz2 or just the links ?
> 

I would definitely be interested in such material myself. We are
actually using the RT patches in real world scenarios on probably 50+
systems (some are development workstations and others are
hardware-in-the-loop simulation test systems) and they perform very
well. However, it would be nice to have a battery of tests (both
correctness and determinism)that could be used to compare future versions.

> hofrat
-
To unsubscribe from this list: send the line "unsubscribe
linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
   kr
