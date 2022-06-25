Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58763C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Jun 2022 02:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiFYC1Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiFYC1V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 22:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E506C3AA46
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 19:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656124040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ou1XEP0BPo6icwSFpk7PWKqyE25oGMYYgA4xnkE+mU8=;
        b=LHWYsZh6bK/787QZVaWpLKlsFdJd0aqDobZiqoI/ru+2VPNI73AXrItvcoR0W+O+S14R40
        sH5Z8vOXsN9IZ8Y1EG9l+u59pHWNgN7wBh1cRK0Zo2XJo3pMUDeZyoYjEJAMiS6zpUmiG/
        7P0wNVGzLlbbx5j9Cfo+fqn2nghOjY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-cwe8s5YqPBCVDny9Z74y8Q-1; Fri, 24 Jun 2022 22:27:16 -0400
X-MC-Unique: cwe8s5YqPBCVDny9Z74y8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8637811E75;
        Sat, 25 Jun 2022 02:27:15 +0000 (UTC)
Received: from [10.22.8.37] (unknown [10.22.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 252C1492CA5;
        Sat, 25 Jun 2022 02:27:15 +0000 (UTC)
Message-ID: <0b08a52a-b348-ca3f-6ea2-4e75498a76b1@redhat.com>
Date:   Fri, 24 Jun 2022 22:27:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Question] vmalloc latency in RT-Linux
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Baoquan He <bhe@redhat.com>
Cc:     Zhipeng Shi <zhipeng.shi0@gmail.com>, linux-mm@kvack.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        shengjian.xu@horizon.ai, schspa@gmail.com, peterz@infradead.org
References: <20220621121547.GB37196@ubuntu20>
 <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
 <dd4f2422-3151-2c0b-e4c6-fe49f6d2ac30@redhat.com>
 <YrUj70P1sYFXsnqf@MiWiFi-R3L-srv> <YrVdtvZgH2aLreOG@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YrVdtvZgH2aLreOG@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/24/22 02:46, Sebastian Andrzej Siewior wrote:
> On 2022-06-24 10:39:43 [+0800], Baoquan He wrote:
>> Then this is a good chance to reconsider it, maybe with a test from Zhipeng.
> I reconsidered and it was dropped purpose, see
> 	https://lore.kernel.org/lkml/YT80AB8%2FG59QBSVq@hirez.programming.kicks-ass.net/

I do agree that is_contended may not that useful for rwlock, but it can 
be useful for spinlock. Will you consider a version just for rt_spinlock?

Cheers,
Longman

