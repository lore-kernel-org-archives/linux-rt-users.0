From: John Sigler <linux.kernel@free.fr>
Subject: Re: Counting CPU_CLK_UNHALTED on an idle system
Date: Fri, 13 Jul 2007 15:02:12 +0200
Message-ID: <469777D4.6060900@free.fr>
References: <46977105.6020604@free.fr> <20070713123712.GC28939@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, oprofile-list@lists.sourceforge.net
To: eranian@hpl.hp.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:33091 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758074AbXGMNCQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 09:02:16 -0400
In-Reply-To: <20070713123712.GC28939@frankl.hpl.hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Stephane Eranian wrote:

> On PIII, CPU_CLK_UNHALTED is broken and keeps on counting while in HALT state.

Stephane,

Would you have a reference?

There is no such mention in the latest Specification Update (May 2007).

http://developer.intel.com/design/intarch/specupdt/244453.htm

Regards.
