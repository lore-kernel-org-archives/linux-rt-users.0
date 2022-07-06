Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6DBC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Jul 2022 08:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGFI61 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiGFI6V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jul 2022 04:58:21 -0400
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 01:58:07 PDT
Received: from mx0.woks-audio.com (mx0.woks-audio.com [88.99.2.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534F2497D
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Jul 2022 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woks-audio.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=woks; bh=XsLXr1LUfFYCTozh8YPjnGAvHpAjyN2ezYwWivV9630=; b=
        czHftXEBd2BBVBMk0an6QKK23zTxS211v0Sn3q8J8flJ4HhJ2fFKJ8UzuZ4F8t4I
        FWyr7qfkFW01GyAvnokoCXZImJeL0zmDpthbVzm5W6/Nf5vf/FpfNmLVxnWbkdLk
        F4V3M84w6dzKDu1JWY3Z89elKM/Je4zRSPFSXVFYBS/Lo5h4W/ynjPyLHz8eQ4SW
        R5HiaC5kmzkDi/+n3qYhttlNXMYNoxLeYBltoUj3GyHbn+3hEuFnC34u+psYlOdL
        G6OYccpfKdB2gqKpH5OFSLH0g7/TkbfHxOrB27u9NkW0uuY99kMvmevk2knn+FAi
        KnWzrfoGjC+N+S6a0Emxnw==
From:   Benjamin Steinke <benjamin.steinke@woks-audio.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: stopping ftrace on event
Date:   Wed, 6 Jul 2022 10:50:11 +0200
Message-ID: <4044532.36S9Iv5CRb@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: EX1.jas.loc (10.100.2.20) To EX1.jas.loc (10.100.2.20)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

I'm hunting sporadic high irq-handler latencies in a pcie driver by using 
ftrace. I'm currently using trace-cmd record but get way to large files due to 
the event being so infrequent.

Is there a way to stop tracing or dump the current trace buffer when a specific 
event occurs?

Thanks for your help,
Benjamin




