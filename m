Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E572C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Dec 2022 18:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiLTSDB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLTSC6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Dec 2022 13:02:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8B17050;
        Tue, 20 Dec 2022 10:02:57 -0800 (PST)
Date:   Tue, 20 Dec 2022 19:02:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671559375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9j5C2VRwJqLdSEv2FsL+J2XPCzIhf29rXsgk0zvHhY=;
        b=CyIGioZoIrhFSQFUmX0+0AEByV5pXZFKe1HSNdsp2CuyRLYN8GlCLshZONMQjEE79Km07P
        ZBwqG0ViBKYHce1PbiDGFuAAoaacXwkuaNm5X2ZJbXbuaJCqm4IXmf/iiBJcCfyzHAo1aw
        8OzECW2yIgSkkuP/PJmZZb5IHRJ3YWbe4gOure63v4BmstZ+aLOfPPg9W2YauVlUDMPwhj
        GzRKvW2EY1yN/qT/aEWIsgnMZI29GOeLuhLWsMNfO8+EkLZ3GfpV/SGpVNq1YkY2npOkFZ
        iwLXN/3L4Nu+zvzsmIwvF/LWaT/jBd1yfiNQS17//sPb64vXeAXgBnaDJ7OcQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671559375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9j5C2VRwJqLdSEv2FsL+J2XPCzIhf29rXsgk0zvHhY=;
        b=v2vsN5kbKzXr9HRgvz4CkgQghXusVbd6TIgT+NyzeYVugtJxarja29zx6SyB3YBJhSgKuV
        /yVICcDku8oe/0Dg==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     "Chang, Junxiao" <junxiao.chang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
Message-ID: <Y6H4zqr8bObRFE1g@linutronix.de>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.

Thanks for the ping. I did see the initial email and I didn't get to it
yet. I need to re-test, confirm and then apply.
The ktimer patch is not in v5.15 and this is currently the latest one
maintained by the stable team. I don't know which one will be the
following LTS kernel but this one needs to have this addressed. The
v5.19 is not receiving any updates.
Given the current timing, I will look into this in January.

> Regards,
> Junxiao

Sebastian
