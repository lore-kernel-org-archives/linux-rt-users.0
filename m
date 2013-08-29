From: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Subject: Re: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Thu, 29 Aug 2013 09:57:56 +0200
Message-ID: <OF4C15C8C3.0B582488-ONC1257BD6.002BC1C3-C1257BD6.002BC1C4@br-automation.com>
References: <521D162D.3030301@osadl.org>,
	<OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:64960 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab3H2H57 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 03:57:59 -0400
In-Reply-To: <521D162D.3030301@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Carsten,

>> I know that in 2.6.33 there were splitted softirqs, and that it was possible to configure each thread with its own priority.
>> What are the steps that need to be done in 3.x to achieve similar results as in 2.6.33?
>The full story is here -> https://www.osadl.org/?id=930.

Thanks for the info, I will have a look at the 3.2 feature branch.

kind regards,
Wolfgang Wallner
