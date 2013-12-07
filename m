From: "Hong H. Pham" <hong.pham@windriver.com>
Subject: Re: [PATCH] powerpc: Fix PTE page address mismatch in pgtable ctor/dtor
Date: Sat, 7 Dec 2013 09:05:18 -0500
Message-ID: <52A32B1E.9050003@windriver.com>
References: <1386258894-21851-1-git-send-email-hong.pham@windriver.com> <874n6muuw4.fsf@linux.vnet.ibm.com> <52A1F804.5000205@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-stable <stable@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:34616 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3LGOFg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Dec 2013 09:05:36 -0500
In-Reply-To: <52A1F804.5000205@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

There is a typo in the v2 patch, please disregard it.  The v3 patch with
the correction will follow.

Thanks,
Hong

On 12/06/2013 11:15 AM, Hong H. Pham wrote:
> Hi Aneesh,
>
> On 12/06/2013 05:38 AM, Aneesh Kumar K.V wrote:
>
>> can you also specifiy the config details here. ie, 4K page size functions
>> are broken ?
>
> My PPC64 config has SMP and 4K page size enabled.  I re-tested with 64K page size,
> and the problem is not present.
>
> I have added a note that this problem affects only PPC32 and PPC64 SMP kernels.
> On PPC64, the problem is limited to 4K page size.
>
>> make it closer to what it was before,
>>
>> pgtable_page_dtor(table);
>> pgtable_free_tlb(tlb, page_address(table), 0);
>>
>> This is what we had before
>>
>> -static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
>> -                                 unsigned long address)
>> -{
>> -       tlb_flush_pgtable(tlb, address);
>> -       pgtable_page_dtor(ptepage);
>> -       pgtable_free_tlb(tlb, page_address(ptepage), 0);
>> -}
>>
>>
>> -aneesh
>>
>
> Done.
>
> Thanks,
> Hong
