From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] mitigate-resched-interrupt-floods
Date: Thu, 26 Jul 2007 09:49:54 +0200
Message-ID: <20070726074954.GA18994@elte.hu>
References: <20070725205814.GA9021@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57233 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756579AbXGZHu3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 03:50:29 -0400
Content-Disposition: inline
In-Reply-To: <20070725205814.GA9021@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Joe Korty <joe.korty@ccur.com> wrote:

> Mitigate rescheduling interrupt floods.

makes sense - i've applied it. (please Cc: lkml too for -rt patch 
submissions in the future - thanks!)

	Ingo
