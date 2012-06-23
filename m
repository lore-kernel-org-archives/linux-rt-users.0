From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 2/3] Oops during Init IRQ
Date: Sat, 23 Jun 2012 12:59:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206231257560.2853@ionos>
References: <20120623030548.500374594@goodmis.org> <20120623030639.113614886@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	leroy christophe <christophe.leroy@c-s.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37385 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2FWK7g (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jun 2012 06:59:36 -0400
In-Reply-To: <20120623030639.113614886@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Jun 2012, Steven Rostedt wrote:

You asked for a changelog. Here you go:

Subject: powerpc: Mark low level irq handlers NO_THREAD

These low level handlers cannot be threaded. Mark them NO_THREAD

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
