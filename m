From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Tue, 27 Feb 2007 11:39:00 -0600
Message-ID: <45E46CB4.1080009@cybsft.com>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay00.pair.com ([209.68.5.9]:1075 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751704AbXB0RjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Feb 2007 12:39:06 -0500
In-Reply-To: <20070205065636.GA1652@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:
> i have released the v2.6.20-rt1 kernel, which can be downloaded from the 
> usual place:
> 

I have a couple of questions regarding priorities of the softirqs, IRQ
handlers, etc.

With some exceptions, back in 2.6.18 and prior patches the IRQ threads
were prioritized between 50 and 25 and the most of the softirqs were
prioritized at 1? In newer patches it looks like they are all
prioritized at 50?

I was just curious what went into making these choices? I am just trying
to better understand these decisions.

Thanks,

-- 
   kr
