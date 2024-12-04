Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D01C3C1B
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339876; cv=none; b=XI1/PfkAjYGy1zusmW3OY5+mieE11nf+QYo86+c12VtQ5EirL1eiafi95megF+5n+EwRN/o8gwjcJi48hSk5knYUf65G57Y3mBswBbNimoc5ljCMTyCvzAAtbvyVPxlZyUOCAX52nWls05nh+bgE0lpagL3mgAA+ekmsoLUP0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339876; c=relaxed/simple;
	bh=6FlSC5o80v+06vfT3sc6JlQbMfXoTz3PewHNj5mlhbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptFhviFw4NIj+FhnJjTxiRharnHz6zEN/idxMvjTv2BHONyaDW01BQfPVsUAZF7oU1U4J3fUHNueIcDiswW/5a/qJtK5kHrxKIq8+EsR59l3I9AJR4kK1Tb+lnK4icxdQMqR5frxmKHDDGC34ilgFDSoHWKaz1bohLxjo/sL80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnI1lWFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnI1lWFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733339873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2YgSaNuqeDNEaUGH3J0EUQjBkPFBabMrVMBikRrJ6dk=;
	b=WnI1lWFy2U8Hd896BoyX/ALrF1Im8e2zIOxr9OSsbpNWNR4e1gR26AffmW4fyxQmU0xhIU
	+0XwW422cQlfJRidegi8FJHJLcBhQ4sojjbsKPlItJRj/ge02fa8WkBegk7OUGqXd84Df2
	g+OkQkhuGqTS6AJ3mLoBkmtxfVYBjxk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-x2dzezSBMe-ByBNJxTE3uQ-1; Wed, 04 Dec 2024 14:17:52 -0500
X-MC-Unique: x2dzezSBMe-ByBNJxTE3uQ-1
X-Mimecast-MFC-AGG-ID: x2dzezSBMe-ByBNJxTE3uQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466cf3f017eso1152401cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Dec 2024 11:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339872; x=1733944672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YgSaNuqeDNEaUGH3J0EUQjBkPFBabMrVMBikRrJ6dk=;
        b=Yd0dIgirl8sLSKNw8DwYECIcoRzzd/PHQuM1lBczZ+OGSxKwRKqJfUAAtBHATpHGNt
         3SJfWZbY0QqMbcsqUEBEn5WwLQQ/6DNu2IHS4kvHWoDBCT4d+kmX2O2gS8g/CJu/5VUe
         3PWSgQthIC5PE3fEyfIJngQ9taAVnzj+mA0cO+5yfryjivW5Ntj7KrqHYNxhLFjUvt69
         o1I5vOykYV6GgNRxLJGuMlkjZC58rxnnanUF5M/T6NgPTd9Q4jvR8FEeAlOz5zQUdSMC
         2q6gYWgBflfKl64tknm8GboDxmL2dmZyguOvlc/HYlHcptXJ87wQ3tU90xpBmH8GZq52
         6yrA==
X-Forwarded-Encrypted: i=1; AJvYcCW+96VkUC/W2VT6miREM0TaSgy3c8OVpOntHKTLj8wk0RTAZuqUFTE5BzUa61Mq+5u0fZWlPs2zvVs3bUddqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLriYPZkzl8fwGLmIh794OLkN6sSBL1r2d3dhkkSUY4m4HKxCr
	bFYP13lRa7Ups6d1xXpO+jjgNHFoIA39rH1+R8f/irteXO4YF6xSm40qs4CSNDJfdZ06YFSXges
	HwGioGcw/5fIRtc9ytpKjxosaEMJb+I10nEqpG7ODZutz/cy8EdJtgObGoBvYexZ5
X-Gm-Gg: ASbGncvE605X5dxyBA9hJxIRkq7PygePiCF2JAL3M+bw6YndOz7BH20VaKOf3e6/OTL
	8Ec/HtC531dz8rPakqXZy40BvGcxLMuV+981+18OU0YWie7nqXJ+mZq4TYSTjzMiZOolK6TD0BU
	EkCCpsKr0sSMyR3EQV+KzaW13Cr14CwSZJlklkCfzeals2khDf/UXnsctqPdgquncb3Fu6t5Wdh
	+CiuRiY7HJNKljcsdxkWc2rIAORqn2XSVxrNpRRjmbsbPRYJQ==
X-Received: by 2002:ac8:580e:0:b0:461:4002:4d1c with SMTP id d75a77b69052e-46717ce5bc7mr101635001cf.50.1733339871783;
        Wed, 04 Dec 2024 11:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE5NqJ1YN5OcpNYW6rq0FeBpHIGDmxuWp/ZQ0Maz9vRByusR7dBZx/KxlaonCSIpSpLsqwRQ==
X-Received: by 2002:ac8:580e:0:b0:461:4002:4d1c with SMTP id d75a77b69052e-46717ce5bc7mr101634541cf.50.1733339871445;
        Wed, 04 Dec 2024 11:17:51 -0800 (PST)
Received: from thinkpad2024.. ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4054955sm76733651cf.1.2024.12.04.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 11:17:50 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>
Subject: [PATCH] tuna: Fix help.py syntax warnings
Date: Wed,  4 Dec 2024 14:17:40 -0500
Message-ID: <20241204191742.16338-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two syntax warnings with what looks like should have been a new line
like the other help entries.

I am struggling to reproduce the scenario that caused them despite it
was after running ./tuna-cli.py. The warnings do not appear most of the
time.

Regardless, these are an issue that can be trivally fixed so sending
a patch.
---
 tuna/help.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tuna/help.py b/tuna/help.py
index fa47ae8..c913a16 100644
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
2.47.0

