From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: Real time application programming - sched_setattr() fails if I
 set CPU affinity using sched_setaffinity().
Date: Mon, 20 Nov 2017 18:43:16 +0100
Message-ID: <20171120174316.2fmwe34nljmexc7n@localhost.localdomain>
References: <CA+bpL9+PrYxrBVX_CQxxqqXv07QGULJfdbCx1zoSu=Bir7hy3w@mail.gmail.com>
 <20171120071847.hqzvqpqqth7e6rcf@localhost.localdomain>
 <CA+bpL9Lm1jjSn224bCH3jdLmeBqaHVKoaku=BsiHJmU4oyHiMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: bhargavb <bhargavaramudu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33212 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdKTRnV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Nov 2017 12:43:21 -0500
Received: by mail-wr0-f176.google.com with SMTP id 4so8845503wrt.0
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Nov 2017 09:43:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+bpL9Lm1jjSn224bCH3jdLmeBqaHVKoaku=BsiHJmU4oyHiMA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 20/11/17 22:03, bhargavb wrote:
> I have used that call/macro, CPU_SET, prior to calling
> sched_setaffinity(), I missed mentioning that in earlier post.. sorry
> for that.

Sorry if I wasn't clear, but I meant that you've got to use the cpuset
interface (not the CPU_SET macro), instead of calling setaffinity, to achieve
what you need. You can find an example here:
https://elixir.free-electrons.com/linux/latest/source/Documentation/scheduler/sched-deadline.txt#L627

Best,

Juri
