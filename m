From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Tue, 6 Feb 2007 01:11:53 +0100
Message-ID: <6bffcb0e0702051611j23c4f160s61196a3c378c38e2@mail.gmail.com>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:29199 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965165AbXBFALz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 19:11:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1458874uga
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Feb 2007 16:11:54 -0800 (PST)
In-Reply-To: <20070205065636.GA1652@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/02/07, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the v2.6.20-rt1 kernel, which can be downloaded from the
> usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>

-rt2 vs. autotest.

Good news - It passes aiostress, linus_stress and ltp.

Bad news - it hangs a few seconds after pi_tests (I don't see any
errors in /var/log/messages)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
