From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 16 Nov 2011 16:06:40 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111161605580.4902@ionos>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com> <4EC384FD.1040106@tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Javier Sanz <jsanza@gmail.com>, RT <linux-rt-users@vger.kernel.org>
To: Thomas Schauss <schauss@tum.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58687 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab1KPPGm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Nov 2011 10:06:42 -0500
In-Reply-To: <4EC384FD.1040106@tum.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Nov 2011, Thomas Schauss wrote:
> Unfortunately, with 3.0-rt and the nvidia-driver we get complete system
> freezes when starting X on several different hardware setups (a few systems
> work fine). This is certainly caused by this combination. When using the
> nouveau-driver everything works fine.

Have you ever tried to run with CONFIG_PROVE_LOCKING=y ?
 
