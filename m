From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: NMI watchdog
Date: Fri, 12 Oct 2007 07:48:36 -0700
Message-ID: <20071012074836.79e6a064@laptopd505.fenrus.org>
References: <470F3BE0.4050807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59877 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbXJLOuf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 10:50:35 -0400
In-Reply-To: <470F3BE0.4050807@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 12 Oct 2007 11:18:24 +0200
John Sigler <linux.kernel@free.fr> wrote:

> Hello,
> 
> I'm experiencing a full system lockup. I'm using an out-of-tree
> driver which I suspect is responsible. I'm trying to enable the NMI
> watchdog.


one thing worth a shot is enabling lockdep.. that often finds deadlocks
for you ;)
