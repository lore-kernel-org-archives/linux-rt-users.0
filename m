From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fix typo in use of BUG_ON_NONRT macro for RT
Date: Wed, 16 Nov 2011 15:47:37 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111161546550.4902@ionos>
References: <1321361887-544-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lkml <linux-kernel@vger.kernel.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58594 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab1KPOrk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Nov 2011 09:47:40 -0500
In-Reply-To: <1321361887-544-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 15 Nov 2011, John Kacur wrote:

> In drivers/md/dm.c BUG_ON_NORT should be BUG_ON_NONRT

Right. I had that fix already, just forgot to refresh the patch. One
day I will teach quilt to do that for me :)
 
