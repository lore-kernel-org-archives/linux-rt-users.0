From: Ken Goldman <kgold@linux.vnet.ibm.com>
Subject: Re: [tpmdd-devel] [PATCH v2] tpm_tis: fix stall after iowrite*()s
Date: Wed, 16 Aug 2017 17:15:55 -0400
Message-ID: <13741b28-1b5c-de55-3945-e05911e5a4e2@linux.vnet.ibm.com>
References: <20170804215651.29247-1-haris.okanovic@ni.com>
 <20170815201308.20024-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tpmdd-devel@lists.sourceforge.net
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752105AbdHPVPO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Aug 2017 17:15:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7GLDwir068258
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Aug 2017 17:15:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ccs47fefj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Aug 2017 17:15:14 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Wed, 16 Aug 2017 17:15:13 -0400
In-Reply-To: <20170815201308.20024-1-haris.okanovic@ni.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8/15/2017 4:13 PM, Haris Okanovic wrote:
> ioread8() operations to TPM MMIO addresses can stall the cpu when
> immediately following a sequence of iowrite*()'s to the same region.
> 
> For example, cyclitest measures ~400us latency spikes when a non-RT
> usermode application communicates with an SPI-based TPM chip (Intel Atom
> E3940 system, PREEMPT_RT_FULL kernel). The spikes are caused by a
> stalling ioread8() operation following a sequence of 30+ iowrite8()s to
> the same address. I believe this happens because the write sequence is
> buffered (in cpu or somewhere along the bus), and gets flushed on the
> first LOAD instruction (ioread*()) that follows.
> 
> The enclosed change appears to fix this issue: read the TPM chip's
> access register (status code) after every iowrite*() operation to
> amortize the cost of flushing data to chip across multiple instructions.

I worry a bit about "appears to fix".  It seems odd that the TPM device 
driver would be the first code to uncover this.  Can anyone confirm that 
the chipset does indeed have this bug?

I'd also like an indication of the performance penalty.  We're doing a 
lot of work to improve the performance and I worry that "do a read after 
every write" will have a performance impact.

