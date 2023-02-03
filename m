Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5368C64EC3
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjBCVQE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjBCVP5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DF3E624
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m26so7017501qtp.9
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYHFwBql9yDJdrtxm7rhuu/vT39X4ElwB4K31Kfb6+0=;
        b=q0jYAd+p5MzI8vnZ9bYIxPN0Ho47S8Dv9yz8wrU/Pul84eYYu5ctYheGuj0IMSkM3a
         FB6YBSKpqVk4atf4agO3TA9B2a8NKnbDLlzvkk+xnKQ4cuAuwl6xwKSn1D//MbZZJPPT
         Wpf3DfRvyHhDXVvyP6xloWiv+yS3QWx8AFSG0r+mD8nY0mM3I3Mc8B64sUrOku6OhjWB
         NsurSF+DJn+PYrCw5fxkXPL0r/CTCVe0BZUj/sL2JoXMMGdlf4jf8rST1hTkVY3ubb2w
         /1+91jPU670QxO6jjP3GZZOMcjRwJa4RsGTzVZp5QFm55FT0lc+aPwv+wIINBgab23C8
         DtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYHFwBql9yDJdrtxm7rhuu/vT39X4ElwB4K31Kfb6+0=;
        b=QDTHKoDawHJUNgT//XanUfVxT9vjSxg4LyhBFcqgDj0eDZwA5cWkqsD9H6AgCD5skw
         yBUJH0ptPnmN7X+clsoLa11/2WYagbJCI/LLBbspdHJozAHL25Mh6xaR4Gq17YwlNhxS
         5ev+yUHOTr8MzF68icf2pk23TvNDi8r0HtstTer7o74dfKoAkovyS8N5kqFel/G5cWaF
         wqeyVAFwm9wCMRE4Ov6FbNZP5DmzdHA1kOfy/TQVUZmKsovK0tUynsYtlJHV560/nLlG
         Yh413++p9xZ/no6MV6Ll86shDi9I1R21ryrLERaTQzdT+qMHYD6e8IkfyRHtuvFJsbtb
         kzAA==
X-Gm-Message-State: AO0yUKXH3r6zYdP51h+112JtbZBSuJ/w7AyOoAbh00wWpRhQM1esdcTd
        tyQTPffo5x1XPchEUWGPTXsHU4zTGXw=
X-Google-Smtp-Source: AK7set8WaoqBkbBvmhKbXbe7iqVQkt1esjA4kP7TL6w/w66tYeTcJaeC1suQ5YtGK68mrxL7ys4GIg==
X-Received: by 2002:a05:622a:13d1:b0:3b6:3596:182b with SMTP id p17-20020a05622a13d100b003b63596182bmr21717166qtk.36.1675458939038;
        Fri, 03 Feb 2023 13:15:39 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/8] rteval: rtevalConfig.py: Convert regular strings to f-strings
Date:   Fri,  3 Feb 2023 16:15:23 -0500
Message-Id: <20230203211527.71181-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert regular strings to f-strings in rtevalConfig.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalConfig.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index decd36ed18ab..de88924642ca 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -196,7 +196,7 @@ class rtevalConfig:
 
         # get our system topology info
         self.__systopology = SysTopology()
-        print(("got system topology: %s" % self.__systopology))
+        print(f"got system topology: {self.__systopology}")
 
         # Import the default config first
         for sect, vals in list(default_config.items()):
@@ -225,7 +225,7 @@ class rtevalConfig:
         "Simple method for dumping config when object is used as a string"
         ret = ""
         for sect in list(self.__config_data.keys()):
-            ret += "[%s]\n%s\n" % (sect, str(self.__config_data[sect]))
+            ret += f"[{sect}]\n{str(self.__config_data[sect])}\n"
         return ret
 
 
@@ -240,7 +240,7 @@ class rtevalConfig:
         for f in ('rteval.conf', '/etc/rteval.conf'):
             p = os.path.abspath(f)
             if os.path.exists(p):
-                self.__info("found config file %s" % p)
+                self.__info(f"found config file {p}")
                 return p
         raise RuntimeError("Unable to find configfile")
 
@@ -258,7 +258,7 @@ class rtevalConfig:
             # Don't try to reread this file if it's already been parsed
             return
 
-        self.__info("reading config file %s" % cfgfile)
+        self.__info(f"reading config file {cfgfile}")
         ini = configparser.ConfigParser()
         ini.optionxform = str
         ini.read(cfgfile)
@@ -321,7 +321,7 @@ class rtevalConfig:
             # Return a new object with config settings of a given section
             return self.__config_data[section]
         except KeyError:
-            raise KeyError("The section '%s' does not exist in the config file" % section)
+            raise KeyError(f"The section '{section}' does not exist in the config file")
 
 
 def unit_test(rootdir):
-- 
2.39.0

