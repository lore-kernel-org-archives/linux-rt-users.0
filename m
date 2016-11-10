From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: The CAT support patch to the rt tree
Date: Thu, 10 Nov 2016 17:42:29 -0500
Message-ID: <20161110174229.494b3f6e@gandalf.local.home>
References: <DDCAE26804250545B9934A2056554AA0211BBD0C@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Jiang, Yunhong" <yunhong.jiang@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:32961 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755639AbcKJWmd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2016 17:42:33 -0500
In-Reply-To: <DDCAE26804250545B9934A2056554AA0211BBD0C@ORSMSX112.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 10 Nov 2016 19:24:24 +0000
"Jiang, Yunhong" <yunhong.jiang@intel.com> wrote:

> Hi, Steven and all,
> 	The CAT patch has been in the tip tree already and hopefully it will be on the next release. I think CAT is important for the real time support and wonder if it makes sense to pull them back to the rt tree, possibly not all the rt tree, but newer one like 4.4 rt tree. If yes, I can contribute to the backport.
> 

4.4-rt is now a stable branch. If people want the latest enhancements
then they should use the latest development.

How invasive are those changes? If they are well contained and don't
touch the main infrastructure, I may consider it. But otherwise, I
rather not.

Feel free to backport them and offer a backported patch yourself. Those
that want 4.4-rt could take the stable tree and apply your patches.

-- Steve
