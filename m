From: "Jiang, Yunhong" <yunhong.jiang@intel.com>
Subject: RE: The CAT support patch to the rt tree
Date: Thu, 10 Nov 2016 22:45:30 +0000
Message-ID: <DDCAE26804250545B9934A2056554AA0211BBDAF@ORSMSX112.amr.corp.intel.com>
References: <DDCAE26804250545B9934A2056554AA0211BBD0C@ORSMSX112.amr.corp.intel.com>
 <20161110174229.494b3f6e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755961AbcKJWpc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2016 17:45:32 -0500
In-Reply-To: <20161110174229.494b3f6e@gandalf.local.home>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> -----Original Message-----
> From: Steven Rostedt [mailto:rostedt@goodmis.org]
> Sent: Thursday, November 10, 2016 2:42 PM
> To: Jiang, Yunhong <yunhong.jiang@intel.com>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Subject: Re: The CAT support patch to the rt tree
> 
> On Thu, 10 Nov 2016 19:24:24 +0000
> "Jiang, Yunhong" <yunhong.jiang@intel.com> wrote:
> 
> > Hi, Steven and all,
> > 	The CAT patch has been in the tip tree already and hopefully it will be on
> the next release. I think CAT is important for the real time support and wonder if
> it makes sense to pull them back to the rt tree, possibly not all the rt tree, but
> newer one like 4.4 rt tree. If yes, I can contribute to the backport.
> >
> 
> 4.4-rt is now a stable branch. If people want the latest enhancements
> then they should use the latest development.
> 
> How invasive are those changes? If they are well contained and don't
> touch the main infrastructure, I may consider it. But otherwise, I
> rather not.
> 
> Feel free to backport them and offer a backported patch yourself. Those
> that want 4.4-rt could take the stable tree and apply your patches.
> 
> -- Steve

Thanks for the explanation.

It's not a small patch set, so I will backport it and see how intrusive it. Will update late.

Thanks
--jyh
