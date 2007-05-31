From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Thu, 31 May 2007 13:26:46 -0300
Message-ID: <20070531162646.GA19685@unix.sh>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org> <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu> <46574DE4.2080900@rncbc.org> <20070531155611.GA9207@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tucuriba.hst.terra.com.br ([200.176.10.214]:58909 "EHLO
	tucuriba.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760711AbXEaQrO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 May 2007 12:47:14 -0400
Received: from buniche.hst.terra.com.br (buniche.hst.terra.com.br [200.176.10.197])
	by tucuriba.hst.terra.com.br (Postfix) with ESMTP id E12A72746D8
	for <linux-rt-users@vger.kernel.org>; Thu, 31 May 2007 13:26:38 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <20070531155611.GA9207@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, May 31, 2007 at 11:56:11AM -0400, Steven Rostedt wrote:
| 
| On Fri, May 25, 2007 at 09:58:12PM +0100, Rui Nuno Capela wrote:
| >
| > I wish I could give you more details, but the fact is I don't know
| > where
| > to look. The machine just freezes silently, again and again, with all
| > kernels from -rt2 to -rt8 inclusive, with no traceable evidence, at
| > least to my knowledge. The only symptom that I can come about is that,
| > from some moment on and ever since, the system cannot start any new
| > process anymore, or otherwise takes forever to realize and launch any
| > new started process thread.

I have also experienced some of these freezes and system hangs, some of them
reproducible, as when I start java+azureus or when xscreensaver pops in. But 
after I unset CONFIG_DEBUG_RT_MUTEXES they are all gone. Not the
DEBUG_RT_MUTEXES has the culpright but judging by the amount of stack
traces it spits every few seconds, this workload may potentialize some
inner problem in the system.

I am currently running rt8 in a FC6 box. I plan to run some further
investigation on this matter.

Luis
 
| I have a box that looks like it's doing the same thing. Unfortunately
| for now it's being used to test other things.
| 
| But I did do a show-task and see a bunch of D processes. I'll post that
| output when I get that box free again.
| 
| -- Steve
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                   lclaudio at uudg dot org ]
[ Fingerprint:   4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8    ]
[ Linux-HA Developer - LateNite Programmer - Gospel User - Bass Player ]
[ Fault Tolerance - Real-Time - Distributed Systems - IECLB - Is 40:31 ]
