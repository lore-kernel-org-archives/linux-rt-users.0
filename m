Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E9FC31E44
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 11:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F342C2082C
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 11:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFphnCaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFNLiB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:38:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45500 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFNLiB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 07:38:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so2131705wre.12
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Jun 2019 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xq0L4hqY88ZHhzv3mvRNUfxuO2PPkfgQ5SwEg0l56Hw=;
        b=cFphnCaBKmgrNHLq9MUHC/B7cm78FCrPJGwizA8onB+ojQh8NVY+s98Qk6BAj4WIoy
         zRf2B5ZjWcYxjQMDwYMmq3fAMf9gxwzCdINtVyAPsoPpfqmesiL4PaFdMULpkcH1j/Lo
         93i1WDgjN1KiMCZm+DsV408t0533Wjp0R8Jaq94lSvHhd3SlGWATezHy+YZV0QmYTEDK
         sHXpZvK5Rxj7eb33HGJ8V6WIR71UsQ01hQONHzE1lDNG8bNZNf8fifOZlEuyNEOuWH/9
         EB04urulrWZLfojfECQvw5to9ACokcLlj4jQwrOYlHQAb+bXiWpvCmhSuy7iLQOgL4rh
         eFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xq0L4hqY88ZHhzv3mvRNUfxuO2PPkfgQ5SwEg0l56Hw=;
        b=pj6+Yk+uFRHa/Qk1GwlPnHbIUPqn/H/v0NQloCcNp6+vmUN6UYi8K4UHfJkjbZ5Y66
         UR24Dq+vliT4muJ5/NPQHc5OBUdWQSIY4nmDqmNnMGIHd9NBFe/6QkOb3xiTW4OgPW29
         QFTDoZ8AE6NiNJLjNVKOOxXoe8KLfz4FbTmfZldDIpcPK6DHjLV5bkkh4Gs9So1h7+5u
         9KHb5PtKv/q/83R0/FOE0TBC7rVnZohxIAqpyzAjswoFfSstxpEL0l8OoaqIGp3wVppY
         e3PPI6GkFH+i88dwnf9gIZ8fIBSNaQZuSRffraSXtRU2qH7ackwbEW5nEnHDErraUxWb
         URCg==
X-Gm-Message-State: APjAAAXAORyFZjOFAaNzsLtT2tooJzSZffiP0PKIyWFmag3RePGBfENp
        3DIFOT+KzMM1RAgzo2d+lBQ=
X-Google-Smtp-Source: APXvYqwbpk9iKgx5h6uSmoytJGd8n1uVBhjFVzH/3coc++mLKziRa5zgZeuz1YxwtTbxnNdqaFTeYw==
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr51041586wrn.212.1560512279330;
        Fri, 14 Jun 2019 04:37:59 -0700 (PDT)
Received: from planxty.home (ip4d14ff42.dynamic.kabel-deutschland.de. [77.20.255.66])
        by smtp.gmail.com with ESMTPSA id u11sm1841376wrn.1.2019.06.14.04.37.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:37:58 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/1] *** Make licence explicit for ssdd ***
Date:   Fri, 14 Jun 2019 13:37:46 +0200
Message-Id: <20190614113747.11565-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The default license for programs in the rt-tests suite is GPL version 2

Joe, I would like to get your signed-off-by for this, or please let us
know if this was not your intention.

thanks

John Kacur (1):
  rt-tests: ssdd: Add Licence information to ssdd

 src/ssdd/ssdd.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.20.1

