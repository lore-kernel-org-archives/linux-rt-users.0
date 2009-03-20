From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: reorder struct Qdisc for better SMP performance
Date: Fri, 20 Mar 2009 01:33:56 -0700 (PDT)
Message-ID: <20090320.013356.246706473.davem@davemloft.net>
References: <49C1DCDF.6050300@cosmosbay.com>
	<20090318.225822.179893347.davem@davemloft.net>
	<49C250DB.3050707@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: sven@thebigcorporation.com, ghaskins@novell.com, vernux@us.ibm.com,
	andi@firstfloor.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	pmullaney@novell.com
To: dada1@cosmosbay.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55693
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756342AbZCTIeK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 04:34:10 -0400
In-Reply-To: <49C250DB.3050707@cosmosbay.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Thu, 19 Mar 2009 15:04:11 +0100

> [PATCH] net: reorder struct Qdisc for better SMP performance

Applied, thanks.

