From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Fri, 19 Oct 2007 22:24:44 +1000
Message-ID: <18200.41484.605753.150546@cargo.ozlabs.ibm.com>
References: <20070921032603.0D3EA32C887@thor>
	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161D79.6000003@ru.mvista.com>
	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>
	<47177229.2030200@ru.mvista.com>
	<18199.63230.583536.307945@cargo.ozlabs.ibm.com>
	<471899D1.2000903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58859 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbXJSMgs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 08:36:48 -0400
In-Reply-To: <471899D1.2000903@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

>     BTW, why not handle the decrementer difference right in set_dec() where we 
> already have #ifdef'ed code?

Excellent idea.  Let's do that.

Paul.
