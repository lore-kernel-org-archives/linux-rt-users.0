From: Daniel Wagner <wagi@monom.org>
Subject: swait question
Date: Tue, 23 Feb 2016 07:59:33 +0100
Message-ID: <56CC0355.6010200@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:54322 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcBWG7f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2016 01:59:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

Sorry, I seem to be offline when you are online and vice verse.

To your question: you need to drop the original swait patches from the
-rt tree before applying the new version. Last time I tried it it worked
without bigger problems.

Sebastian would you mind integrating the new version of the swait
patches? I guess it doesn't hurt to give them a some testing via the -rt
tree.

cheers,
daniel
