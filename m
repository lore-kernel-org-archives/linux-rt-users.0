Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F495C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Nov 2022 13:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiKONU7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 08:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiKONU5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2022 08:20:57 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B8DFC8
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Nov 2022 05:20:54 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k84so12921763ybk.3
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Nov 2022 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K3JxfCQyoTcwiL8SOr4yfnezuS8moZuwjQi6ZmeUgUU=;
        b=qz36rE3sir3zRbz+wi93HU1zBWZV06Ofyy4NzEYnGgWoZClTJXS/Hy6IUrpZ4IAvld
         PAumhSY7b9PKkxcmG+hlbTcy/P6z3viwz8AQlrw3hWWhgZeCkbnZ3vGzfE8bDq+UPfCz
         h1/wwGEqcN3FM7LQDY3dWQ3ePIJPTNnuHOjYtWQXAKu1KFiCtwy04D2ItL2uqEq0T1K7
         M+VRJwXRDRDivEnDJMHU+macQjPDxTphONWqRZI+j0o3dGfV4vl7zTk1765/WaPaF8gP
         88IXnLrDPu7xRot3Bws3WiL5v+ptgWaq/Q+HZbCNww/d+ZbsPqbz8sO86TmDYn4So7cd
         Nj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3JxfCQyoTcwiL8SOr4yfnezuS8moZuwjQi6ZmeUgUU=;
        b=29Upq2C4Q0Tmt1r48vuyIkUiX5kJyKZlgK0yiDR11qhZqkzQ6pezJTUwC7ZkHeKlHK
         qU7bCka5VMDcagJne4p0rXrXN6c8s4OpXoZKwc0SvxDzHiJ+OWbXhQeclr7ywsIT+mOa
         5Nln5GagLV+dYDFBdGjI20WiaW/jC3rjsotU1kKydPmOvRtsW9s4adlTucTRTvE9mqYU
         wvqjd/+wEkA1OmplmJji7PBgUWCETEUu6hgbUF/2kDrZT+KRtR75EkuMTyzRUWaRDbsm
         9xeOtvp5vqgLZCrmhbf+yIUm+D0CY4j4PaarmyAsCjPJf71zyhGbb5Qm3SWnlMlZb8dT
         UyIg==
X-Gm-Message-State: ANoB5pkx6Ua24xjWRD1Cu/KeNWjLB1Nrcdo6JHEk2OnnizA4pdVOXblc
        YXJjojBViKbKu2ZUxkvWZq7UG7xs5FGyN2sI/Ehl1Nu66wc=
X-Google-Smtp-Source: AA0mqf6TVfDb2bhCV6NepG7MYmMsBe8NXdQp83QS7TsIDb4V4O1g2inHax1lEnLKFCHgE7OidQ4K/XN0W96jIFL9ZA0=
X-Received: by 2002:a25:29c3:0:b0:6d3:152d:5583 with SMTP id
 p186-20020a2529c3000000b006d3152d5583mr15445416ybp.608.1668518453019; Tue, 15
 Nov 2022 05:20:53 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 15 Nov 2022 14:20:42 +0100
Message-ID: <CAKXUXMz9HQO29oVcrPOdCxVqqjtQRKpHAyMQp+MKpccpG93+tw@mail.gmail.com>
Subject: Linux Real-Time Blog Updates
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear all,

I updated the Linux Real-time Blog with pointers to two LWN.net articles:

https://wiki.linuxfoundation.org/realtime/rtl/blog#lwnneta_discussion_on_printk
https://wiki.linuxfoundation.org/realtime/rtl/blog#lwnnetbetter_cpu_selection_for_timer_expiration

I am not sure if the second article is strictly related to the Linux Real-time
Project or not, but my gut feeling was to add a pointer in the blog.

Please let me know about any feedback you have or if there is anything else that
should be mentioned.


Best regards,

Lukas
