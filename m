From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Wed, 07 Jul 2010 10:03:04 +0200
Message-ID: <1278489784.7493.2.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39577 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab0GGIDF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 04:03:05 -0400
In-Reply-To: <1278478019.10245.77.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


FWIW, 2.6.31.14-rt21 explodes too (darn).

