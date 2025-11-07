Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05E33C527
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541886; cv=none; b=ozqILB1l77qtpdjKRE6fd4/2q72+1CR1JxB0q9m49lO16ZJ00KB7GPH+Vx5WP7S5xuX0yIeu/onQEs+4Wel86RnykPQ+oTNAc0c4VcrEKbYF+3RArnxWrGwf1UmIcNo1NuvjTR22hpuIK4LjH1k+NK4RSl4WSqaPwWeQSInM9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541886; c=relaxed/simple;
	bh=76zboQNThJIAhB+KM215l2ZxDXAz+iPBrIqdrZ6Dxg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2q8U0oujojSsYB+zBL9lQaGFZUnzlOv97R1eYNmt0zBOiHuTwBpSAxmldmvsnmxKfqjEMBk4yc0YxjcfVRghy9S4qqURtlwqP7W/PGWqleL1r5vngk6u16goP8qihaxj8kalLgr7ClssTMGSi0ZTznShjT5GTiCyUzszdoR//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAdVd0Za; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAdVd0Za"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-891208f6185so83411485a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541883; x=1763146683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khqlywh2INVZCJ5UNzT4kUdLz+phbr4/ThWP0dYL5/Q=;
        b=bAdVd0ZabblYhuAijk3NtqIDWi3ow2dkExYv1KNOoNubiziYyKbq/hDTH1SH/RF2bc
         Z1zTpjLXgPGvBuX3atGwga6m4lV0VQr4aNjj3wi26qryzgra2Mn8hrIbhQNMpdA5iczv
         5lFNNSpdFSsIxgOjPA6NrsPrWw6dYotyYBJdJ0x2cUA2VI4VnPJ0TdqsJyQVgXfRvwPV
         0/VCkZcYLQwAsswcHPfU2ZQBfVUTX8pYfujHkMNxABVEsVUW1zVpo/7fwSrCLgbLJf94
         jMuPZrJFq5LuZ4aNouv8ScJ0q36Q57U/+cdxoYXlJyqQG1FX6AJ16kx1C/Jc3rom5iNO
         v/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541883; x=1763146683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Khqlywh2INVZCJ5UNzT4kUdLz+phbr4/ThWP0dYL5/Q=;
        b=b/e4a1hGG6cBFEEKDH70nZb3LyHcEaSZCYYafJcSgtWQ+igwI3AI+tbW6wteuJWxTs
         3/kZ9tpd+vQ83nxk6KCesI5fyGXS/DEDhlfOGQ024eRwEC9Xs1LpeixcL3yFKIkxffg9
         GCUOomX4UJWyggAnTznCK0Jgba9xmQkbDR4BQulVshjnJ99mwHuHJBWzv1ZhgP2s7ghe
         OGA8pIeJZgV4bWeDsLvTSteiQn3CSYhSznFBGiO9FiNCN1GwHyeF6IzBMhtLdNfkd9QN
         rLvFhchWQiG2+HoWAz5GikVqsdVi0ews3F9T3LhNpBuRo73hQ4TVenCjPOMcO7zW5tT9
         wSrw==
X-Gm-Message-State: AOJu0YzlpwFsUPcY6cNRShUrNHx92bsX8G7MVlRqdp/skFkZuUWiwKDW
	jJ5EnpWMz5S7Cs0QPbyuXItgBHW1ramNeOr/GfgVwkUlCEYznlHkC/7GS5XZH1ZT
X-Gm-Gg: ASbGncsOKOsn6IF6qH2OGRc5JlrUV/Y86gYIlcaDxcBnYXaLatRO0mMHWu50jAroXfv
	cr2AD8tLHvoGm1cOV9nzURG0SHVzIK5rP8GJwELYgeL8QYwaYoHq5PHTh7H/u2OfiuCT67H2w+h
	M+EN7pPIQPH9fRpqSn/mLCa3GHuLyNTyyIi6AwycuCDFQZczBsLqOXEZGR5iBT0t6bvgWFwvQjD
	zeew5MKbcBgWq5Y4TCKa2UBh8Ic1Nxdb6fUIOpWGNLX/uWxRs5qTUz88bSwahzl0GlN56ZQZ6Eq
	duEB+InxBn23ODpsJYhcZj5jQ5v2iBoBAiKjWqJm8Kdfxdmou8sib4n/RI2wNuH0hWUj2DmmWe1
	5eJf1lWMvEdK7qgN5PThbRKCqyZ0EodQBHBEm8I3R+J/LonnFeGAcCAHwOqR8iYM=
X-Google-Smtp-Source: AGHT+IG1Xdsv4Qd1y2FZA9ilDdz9opWO7KBluRt3lrn4dbPRtvnVG+xJzWaToojWIyiq7ByIcM5D2w==
X-Received: by 2002:a05:620a:460e:b0:8b2:1fbc:4ee9 with SMTP id af79cd13be357-8b257ef952dmr42311185a.3.1762541882889;
        Fri, 07 Nov 2025 10:58:02 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:02 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 05/23] tuna: Fix help.py syntax warnings
Date: Fri,  7 Nov 2025 13:57:14 -0500
Message-ID: <20251107185732.23992-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "John B. Wyatt IV" <jwyatt@redhat.com>

Fix two syntax warnings with what looks like should have been a new line
like the other help entries.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
- edited commit message
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/help.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tuna/help.py b/tuna/help.py
index fa47ae835962..c913a16f4a40 100644
--- a/tuna/help.py
+++ b/tuna/help.py
@@ -44,7 +44,7 @@ PROC_SYS_HELP = {
 	'net.core.rmem_default':N_('The default setting of the socket receive buffer in bytes.'),
 	'net.core.rmem_max':N_('The maximum receive socket buffer size in bytes.'),
 	'net.core.rps_sock_flow_entries':N_('This controls the maximum number of sockets/flows that the kernel can steer towards any specified CPU. This is a system-wide, shared limit.'),
-	'net.core.somaxconn':N_('Limit of socket listen() backlog, known in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuning for TCP sockets.\Default: 128.'),
+	'net.core.somaxconn':N_('Limit of socket listen() backlog, known in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuning for TCP sockets.\nDefault: 128.'),
 	'net.core.warnings':N_('This controls console messages from the networking stack that can occur because of problems on the network like duplicate address or bad checksums. Normally, this should be enabled, but if the problem persists the messages can be disabled.'),
 	'net.core.wmem_default':N_('The default setting (in bytes) of the socket send buffer.'),
 	'net.core.wmem_max':N_('The maximum send socket buffer size in bytes.'),
@@ -118,7 +118,7 @@ PROC_SYS_HELP = {
 	'net.ipv4.tcp_reordering':N_('Maximal reordering of packets in a TCP stream.\nDefault: 3'),
 	'net.ipv4.tcp_retrans_collapse':N_('Bug-to-bug compatibility with some broken printers. On retransmit try to send bigger packets to work around bugs in certain TCP stacks.'),
 	'net.ipv4.tcp_retries1':N_('This value influences the time, after which TCP decides, that something is wrong due to unacknowledged RTO retransmissions, and reports this suspicion to the network layer.\nRFC 1122 recommends at least 3 retransmissions, which is the default.\nDefault: 3'),
-	'net.ipv4.tcp_retries2':N_('This value influences the timeout of an alive TCP connection, when RTO retransmissions remain unacknowledged. Given a value of N, a hypothetical TCP connection following exponential backoff with an initial RTO of TCP_RTO_MIN would retransmit N times before killing the connection at the (N+1)th RTO. The default value of 15 yields a hypothetical timeout of 924.6 seconds and is a lower bound for the effective timeout. TCP will effectively time out at the first RTO which exceeds the hypothetical timeout. RFC 1122 recommends at least 100 seconds for the timeout,	which corresponds to a value of at least 8.\Default: 8'),
+	'net.ipv4.tcp_retries2':N_('This value influences the timeout of an alive TCP connection, when RTO retransmissions remain unacknowledged. Given a value of N, a hypothetical TCP connection following exponential backoff with an initial RTO of TCP_RTO_MIN would retransmit N times before killing the connection at the (N+1)th RTO. The default value of 15 yields a hypothetical timeout of 924.6 seconds and is a lower bound for the effective timeout. TCP will effectively time out at the first RTO which exceeds the hypothetical timeout. RFC 1122 recommends at least 100 seconds for the timeout,	which corresponds to a value of at least 8.\nDefault: 8'),
 	'net.ipv4.tcp_rfc1337':N_('If set, the TCP stack behaves conforming to RFC1337. If unset, we are not conforming to RFC, but prevent TCP TIME_WAIT assassination.\nDefault: 0'),
 	'net.ipv4.tcp_rmem':N_('Vector of 3 values: min, default, max\n - min: Minimal size of receive buffer used by TCP sockets. It is guaranteed to each TCP socket, even under moderate memory pressure.\nDefault: 8K\n - default: initial size of receive buffer used by TCP sockets. This value overrides net.core.rmem_default used by other protocols. Default: 87380 bytes. This value results in window of 65535 with default setting of tcp_adv_win_scale and tcp_app_win:0 and a bit less for default tcp_app_win. See below about these variables. - max: maximal size of receive buffer allowed for automatically selected receiver buffers for TCP socket. This value does not override net.core.rmem_max.  Calling setsockopt() with SO_RCVBUF disables automatic tuning of that socket\'s receive buffer size, in which case this value is ignored.\nDefault: between 87380B and 4MB, depending on RAM size.'),
 	'net.ipv4.tcp_sack':N_('Enable select acknowledgments (SACKS).'),
-- 
2.51.1

