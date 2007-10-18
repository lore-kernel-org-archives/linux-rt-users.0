From: David Miller <davem@davemloft.net>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Thu, 18 Oct 2007 05:52:42 -0700 (PDT)
Message-ID: <20071018.055242.115933276.davem@davemloft.net>
References: <20071018124827.GA22282@in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@us.ibm.com, kravetz@us.ibm.com
To: ankita@in.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58980
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757189AbXJRMw3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 08:52:29 -0400
In-Reply-To: <20071018124827.GA22282@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: ankita@in.ibm.com (Ankita Garg)
Date: Thu, 18 Oct 2007 18:18:27 +0530

> Any thoughts on where in the code could these large latencies be
> attributed to?

If the max latency is usually the first one, it's could be the page
fault the signal handler is taking the first time it is executed.
