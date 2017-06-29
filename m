From: "Zhou, Li" <li.zhou@windriver.com>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Thu, 29 Jun 2017 16:42:10 +0800
Message-ID: <2a824587-65ba-6d37-c22c-7b795512fee9@windriver.com>
References: <6a05f9f4-9299-4b36-7f11-5e334768880a@windriver.com>
 <85216e5b-7c2d-9ff7-c118-9279023a1726@windriver.com>
 <fd047718-33e1-a103-0530-453fadbb2076@windriver.com>
 <f2d4cc83875c496bb7c1bab25c7a16b5@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Koehrer Mathias (ETAS/EHE1)" <mathias.koehrer@etas.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:39477 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdF2ImB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2017 04:42:01 -0400
In-Reply-To: <f2d4cc83875c496bb7c1bab25c7a16b5@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, Mathias:

         Thank you very much for your help. The related changes can 
solve my issue.


On 06/29/2017 03:45 PM, Koehrer Mathias (ETAS/EHE1) wrote:
> Hi,
>> Issue with gdb and unexpected SIGSTOP signals" in this mail list, I wonder if there is
>> any update for this.
>> I want to follow this thread too, because I meet almost the same issue.
>> My kernel version is based on rt kernel 4.8.x.
> According to the announcements this should be fixed with v4.9.33-rt23.
> Please read the announcements for this version and the one for 4.9.30-rt21.
>
> Regards
>
> Mathias
>

-- 
Best Regards!
Zhou Li
Phone number: 86-10-84778511

