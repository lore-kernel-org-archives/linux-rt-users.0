From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 13:59:56 +0100
Message-ID: <6bffcb0e0702050459y692359ai67cbd4f93e11d06e@mail.gmail.com>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:62972 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbXBEM76 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 07:59:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1285387uga
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Feb 2007 04:59:57 -0800 (PST)
In-Reply-To: <20070205065636.GA1652@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 05/02/07, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the v2.6.20-rt1 kernel, which can be downloaded from the
> usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>

It looks like a bug to me

BUG: MAX_LOCKDEP_ENTRIES too low!
turning off the locking correctness validator.

http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rt1/rt-dmesg
http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
