From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.22.1-rt5
Date: Tue, 24 Jul 2007 14:04:36 +0200
Message-ID: <20070724120436.GA14466@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40653 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbXGXMEm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 08:04:42 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


i've released the v2.6.23-rc1-rt0 kernel, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

as the rt0 name suggests it, this is a devel release, the first one 
after a rebase to 2.6.23-rc1. There's lots of changes and a reduction of 
50 patches (we are now at 320 patches) - so code from -rt is moving 
upstream at a steady pace. (latest bigger chunks that moved were CFS, 
lockstat, most of the -hrt queue, plus various fixes)
   
more info about the -rt patchset can be found in the RT wiki:
    
  http://rt.wiki.kernel.org
 
to build a 2.6.22.1-rt5 tree, the following patches should be applied:

 http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.23-rc1.tar.bz2
 http://redhat.com/~mingo/realtime-preempt/patch-2.6.23-rc1-rt0
  
	Ingo
