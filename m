From: "Peter C. Wallace" <pcw@mesanet.com>
Subject: Re: Ethernet chunks behavior
Date: Sun, 10 Dec 2017 07:58:37 -0800 (PST)
Message-ID: <Pine.NEB.4.64.1712100757170.29049@freeby.mesanet.com>
References: <CAJ2oMhLR0U3kPB1fYxdTvVoy4FuNDBW2xj7CswiWkATZhROFww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from freeby.mesanet.com ([108.95.56.89]:57719 "EHLO
        freeby.mesanet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdLJQTr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Dec 2017 11:19:47 -0500
In-Reply-To: <CAJ2oMhLR0U3kPB1fYxdTvVoy4FuNDBW2xj7CswiWkATZhROFww@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 10 Dec 2017, Ran Shalit wrote:

> Date: Sun, 10 Dec 2017 17:40:27 +0200
> From: Ran Shalit <ranshalit@gmail.com>
> To: linux-rt-users <linux-rt-users@vger.kernel.org>
> Subject: Ethernet chunks behavior
> 
> Hello,
>
> We use rt patch with UBUNTU,and have a "high priority" thread with 1
> millisecond periodic rate.
> That rt thread, also send UDP Ethernet packets.
> This project was ported from VXWORKS project, but we notice the
> following difference:
> Although the rt thread gets its 1 millisecond periodic in high
> accuracy, the udp is being send in chunks, as if several messages are
> aggregated before being delivered.
>
> Is there any reason for such behavior ?
>
> Regards,
> Ran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Is it possible your Ethernet driver has coalesce options enabled?

Check with ethtool -c devname


Peter Wallace
Mesa Electronics

