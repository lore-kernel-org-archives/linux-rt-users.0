From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/6: v4] lockdep: Make MAX_STACK_TRACE_ENTRIES
 configurable.
Date: Wed, 16 Jun 2010 20:49:14 +0200
Message-ID: <1276714154.1745.623.camel@laptop>
References: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
	 <1276554087-3632-3-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@elte.hu>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:55712 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab0FPSt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jun 2010 14:49:26 -0400
In-Reply-To: <1276554087-3632-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-06-15 at 00:21 +0200, John Kacur wrote:
> Certain debug configurations that have LOCKDEP turned on, run into the limit
> where the MAX_STACK_TRACE_ENTRIES are too small. Rather than simply turning
> off the locking correctness validator, let the user configure this value
> to something reasonable for their system.
> 
> This patch was generated against 2.6.33.5-rt23 but is also intended to be
> picked-up for mainline.

NACK

patches like 4726f2a617ebd868a4fdeb5679613b897e5f1676 are the way to go.
