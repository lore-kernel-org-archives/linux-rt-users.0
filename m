Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78885C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiKKTxn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiKKTxl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:41 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E317E0D
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:40 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 8so3613439qka.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l55w9Fc5LSZrTMC1IANBZ3n08WMrT2Fhk7XPfCBQ+6U=;
        b=Eykk8Im1DivowC+YWv1i6LYqr476EDZCUet65mFnNCkwklHzOE/UdN9ou2rASeBS8M
         26v203vwdlhx/SgJCTIAWfuh3X+PR6pkF/2I3vboF67PcUngQjCwgqv12+NwbTFqF0dt
         tmjF1MgGYZR2DzTOxNkpJMIu8b1PbKEGBGKwE7GVL6+V0MnscMH4ybirD0swx8BmLkmd
         E3xHp8V6cc8md4rRk/NO0eQBMlqjgNdMpiwIaj2uSg1ZvkpFqEKrsPLnDzeGols7WPfS
         4qYkFPuu8ePtZh48p5AJB7TU36PQTo3K9ajks51o7rRbQp+Hjdh8/0ujHwdS0B9W/Unf
         yPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l55w9Fc5LSZrTMC1IANBZ3n08WMrT2Fhk7XPfCBQ+6U=;
        b=6appegFCd2y17dWKsSEAaGLWEVBXN/n5bpOQui5jxaRF2x8sN9LT/9AGcXmPpMEeCi
         Il/2ZVcnGbH4WsFK65w2YF+AnyJQuELZA1cZplgREi9vhY0Yb4wg/t0yFXQKDNzfrHA4
         iAWELqVQn6tVzYl/f7bcoN72FWYy0S0vVPdbFFEc3NJbH2xgq3FQNYI44U6+CmMc1nk7
         wBIq8grr73QiKgF5fHRQBD2g/jFI1I9JNTclEX+ywrKjfG5EdtOdeVvMkP0KyZ1hpm4D
         2WUHD1qLLQafjxRpv843Vs1HvpmUcTixvfGCfsN8HrhYNK4+Q5JVudB90Z/QxkLIjjE6
         Yluw==
X-Gm-Message-State: ANoB5pn+fbC9dO2488KytiHjuIVf6oQYbh3nFhJCxZHEWNr/CFJd50HX
        Xq8Wv92HSXW1nxUmPTFHE/A7eFub4fk=
X-Google-Smtp-Source: AA0mqf7s/FdmPyYgOd/4sGi5cp1l18tYv46i0/Xm3D0y1EnuqwTmICtuXe2OWTpL3CjLN+fnKz61Ig==
X-Received: by 2002:a37:a95:0:b0:6fa:56bd:eb3f with SMTP id 143-20020a370a95000000b006fa56bdeb3fmr2495360qkk.529.1668196419203;
        Fri, 11 Nov 2022 11:53:39 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/8] rt-tests: hackbench: Fix compile warning about fall through
Date:   Fri, 11 Nov 2022 14:53:19 -0500
Message-Id: <20221111195323.27402-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

print_usage_exit(0) never returns, but the compiler doesn't understand
this. In any case it is not harmful to add a break after this statement.
Do so to keep the unhelpful compiler warning from triggering.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hackbench/hackbench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index dda7690b79a0..69dd5f087fb6 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -444,6 +444,7 @@ static void process_options(int argc, char *argv[])
 			break;
 		case 'h':
 			print_usage_exit(0);
+			break;
 		case 'l':
 			if (!(argv[optind] && (loops = atoi(optarg)) > 0)) {
 				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
-- 
2.38.1

