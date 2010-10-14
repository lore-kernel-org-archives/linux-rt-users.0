From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: 2.6.35 + rt?
Date: Thu, 14 Oct 2010 15:02:11 -0700
Message-ID: <4CB77DE3.40904@am.sony.com>
References: <4CB3A520.9040300@ccrma.stanford.edu> <4CB5EDED.10100@localhost> <4CB76916.5000902@am.sony.com> <4CB77122.40408@localhost>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:24000 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab0JNWCs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Oct 2010 18:02:48 -0400
In-Reply-To: <4CB77122.40408@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/14/10 14:07, Fernando Lopez-Lezcano wrote:
>   On 10/14/2010 01:33 PM, Frank Rowand wrote:
>> On 10/13/10 10:35, Fernando Lopez-Lezcano wrote:
>>> On 10/11/2010 05:00 PM, Fernando Lopez-Lezcano wrote:
>>>> Any news on the above combination? I can test if there is something
>>>> available...
>>> Hmmm, looks like the git repo is tracking 2.6.36 up to rc7. I presume
>> Which branch of which repo is that?
> 
>  From here:
> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Download
> 
> I go to:
> http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=summary

OK, branch master is 2.6.37-rc7 (according to Makefile), but the various
rt branches that I looked at are not.  Branch master does not appear to
contain the RT patches.

There are a lot of different rt branches, and I did not look
at all of them, but I looked at several obvious possibilities.
 
As of the 2.6.22-rt3 announcement, branch rt/head was going to follow the linus tree
but is currently 2.6.33-rt (according to Makefile), and was last modified March 3.

Branch rt/2.6.33 is currently 2.6.33.7.1-rt29, last modified Sept 16.

The other rt branches I looked at are older.

So it looks to me like the latest RT development in git is currently at
2.6.33.7 plus a few changes.  Am I understanding this correctly?

Thanks,

Frank


