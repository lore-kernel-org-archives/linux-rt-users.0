From: David Sommerseth <davids@redhat.com>
Subject: Re: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Tue, 09 Mar 2010 19:10:51 +0100
Message-ID: <4B968F2B.4070708@redhat.com>
References: <20100307204800.456744470@osadl.org> <20100307204909.626988443@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab0CISK6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 13:10:58 -0500
In-Reply-To: <20100307204909.626988443@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/03/10 21:48, Carsten Emde wrote:
> -		if (priority > 0)
> +		if (priority > 1 && !sameprio)
> 			priority--;

Unless I'm missing something really obvious, shouldn't this one state:

	if (priority > 0 && !sameprio)
		priority--;

Or else 1 will be the lowest priority.  It's a similar situation in
"[PATCH 1/2] add-smp-option-to-ptsematest.patch" as well.


kind regards,

David Sommerseth
