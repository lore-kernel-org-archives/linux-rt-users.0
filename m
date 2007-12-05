From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] Subject: SCHED - Use a 2-d bitmap for searching
	lowest-pri CPU
Date: Wed, 5 Dec 2007 10:34:12 +0100
Message-ID: <20071205093412.GA17911@elte.hu>
References: <20071205025137.4494.18683.stgit@novell1.haskins.net> <20071205025538.4494.52380.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:47524 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbXLEJe1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 04:34:27 -0500
Content-Disposition: inline
In-Reply-To: <20071205025538.4494.52380.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> The current code use a linear algorithm which causes scaling issues on 
> larger SMP machines.  This patch replaces that algorithm with a 
> 2-dimensional bitmap to reduce latencies in the wake-up path.

hm, what kind of scaling issues - do you have any numbers? What workload 
did you measure and on what hardware?

	Ingo
