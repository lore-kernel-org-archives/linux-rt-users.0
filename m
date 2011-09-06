From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: kmem_cache_destroy issue with RT12 patch on v3.0.3 (perhaps
 related to thread 3.0.4 + rt12: deadlock?)
Date: Tue, 06 Sep 2011 13:58:50 +0200
Message-ID: <1315310330.12533.2.camel@twins>
References: <FBCF5AA02BB36243866FEDBD9889FC720637233484@uk-ops-exch01>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: PRINGLE Chris <chris.pringle@miranda.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35249 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1IFL67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Sep 2011 07:58:59 -0400
In-Reply-To: <FBCF5AA02BB36243866FEDBD9889FC720637233484@uk-ops-exch01>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-09-02 at 12:02 +0100, PRINGLE Chris wrote:

> The following code causes the a kernel OOPS at the point where I call
> kmem_cache_destroy:
> 


What does that oops look like?
