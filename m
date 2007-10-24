From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH 13/13] RT: Cache cpus_allowed weight for optimizing migration
Date: Wed, 24 Oct 2007 02:19:23 +0200
Message-ID: <200710240219.25487.ioe-lkml@rameria.de>
References: <20071023164156.5536.95573.stgit@novell1.haskins.net> <20071023165130.5536.73345.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:59278 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbXJXAX0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 20:23:26 -0400
In-Reply-To: <20071023165130.5536.73345.stgit@novell1.haskins.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Gregory,

On Tuesday 23 October 2007, Gregory Haskins wrote:
> Calculating the weight is probably relatively expensive, so it is only
> done when the cpus_allowed mask is updated (which should be relatively
> infrequent, especially compared to scheduling frequency) and cached in
> the task_struct.

Why not make it a task flag, since according to your code, you are only 
interested whether this is <= 1 or > 1. Since !(x <= 1) <=> (x > 1)
for any given unsigned integer x, the required data structure is
a "boolean" or a flag.


Best Regards

Ingo Oeser
