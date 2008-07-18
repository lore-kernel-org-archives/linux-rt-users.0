From: "Christian Volk" <linux.kernel@cvolk.de>
Subject: Questions About preempt-rt and arch:ppc
Date: Fri, 18 Jul 2008 21:20:56 +0200 (MEST)
Message-ID: <200807181920.m6IJKucY010585@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p00-ob.rzone.de ([81.169.146.192]:16915 "EHLO
	cg-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYGRT1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 15:27:54 -0400
Received: from post.webmailer.de (hat.store [192.168.40.68])
	by bjorn-cg-03.store (RZmta 16.42) with ESMTP id v04ee3k6IIPrUU
	for <linux-rt-users@vger.kernel.org>;
	Fri, 18 Jul 2008 21:20:56 +0200 (MEST)
	(envelope-from: <linux.kernel@cvolk.de>)
Received: (from httpd@localhost)
	by post.webmailer.de (8.13.7/8.13.6) id m6IJKucY010585
	for linux-rt-users@vger.kernel.org; Fri, 18 Jul 2008 21:20:56 +0200 (MEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

is it possible to get preempt-rt working with kernel 2.6.20 / 2.6.21 with arch ppc 
(processor is a Freescale MPC8343)?
Unfortunately it is not possible for me to change the arch to powerpc.

Kernel 2.6.20/21 compiles fine runs and boots without the patch.
After applying the patch and fixing some small issues i can configure it, but while building
it, i get a lot of warnings concerning about redefinition of functions.

My question is, is it possible to get the above combination working or not?

thanx in advance,

christian
