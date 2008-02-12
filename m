From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] add task migration_disable critical section
Date: Tue, 12 Feb 2008 14:22:40 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802121420470.21926@gandalf.stny.rr.com>
References: <20080212182512.10902.66459.stgit@novell1.haskins.net>
 <20080212183000.10902.97544.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34981 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYBLTXL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2008 14:23:11 -0500
In-Reply-To: <20080212183000.10902.97544.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 12 Feb 2008, Gregory Haskins wrote:

> This patch adds a new critical-section primitive pair:
>
> "migration_disable()" and "migration_enable()"

This is similar to what Mathieu once posted:

http://lkml.org/lkml/2007/7/11/13

Not sure the arguments against (no time to read the thread again). But I'd
recommend that you read it.

-- Steve
