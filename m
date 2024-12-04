Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349F1531E8
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344382; cv=none; b=M8yL9Xp9bttJFlH+QEHCnbntvfivj+x2mmxBZxQa1azSSBgNRaNjjYFplvKbNvQEDe66xPLCWD+sBDW2pJ4Edt1I/fcPYn0qIQsS13M0NwOWQ+HPcfGElSgX5lbTlU0Td+wsRXBQfLXdC83bL/83tkeu6Up5wYEHSIPUAL/Ye2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344382; c=relaxed/simple;
	bh=kEWbBi7YBw2iwJxTDsU3V8YuT6qLVI91t+gs/JaUsJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqrQCzYsS3dqSTTnYKYjECUHXGo3R7cp8thOYnAkDIscWrZS9jWLi0o1cGsZGqBfIArYgJePpsdZDowUP/QQjHnfQHGMeFpqGAx6x2KVue35xfzm9ns5FnWOaeMVdWpdwCNmJrreyJLPEbBIYHWpL7Sb7tqav6mse8fMV93tv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmT7HNSI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmT7HNSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733344377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NQACdpUXR0RWWUvqm2l/ZqEiG36ohqkFxLdy+/XtZd8=;
	b=DmT7HNSIQ+pvkL8IEahGMKYfhwt+zrHYSMKWs6sek5Kt0M/h8ALtNUwtMatuUCyMlRnJKd
	KBycUhaXaF4aOCL8Q1foCMVJIOPqj/xNuAjtRWxR5ANZMQ9YiMAQFxz79TMbl+7e7UdFwM
	HXl0o18vJ9ioi1PeMr4SuM6tZO/aHqY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-C0osbSQHPTW6Xdm67LIs5w-1; Wed, 04 Dec 2024 15:32:55 -0500
X-MC-Unique: C0osbSQHPTW6Xdm67LIs5w-1
X-Mimecast-MFC-AGG-ID: C0osbSQHPTW6Xdm67LIs5w
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b66773ac24so15323085a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Dec 2024 12:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344374; x=1733949174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQACdpUXR0RWWUvqm2l/ZqEiG36ohqkFxLdy+/XtZd8=;
        b=fnCXnUzLYLovadw2IagA2H+vwhETsgV2l1O5irrWq0HPZfLy7arkkmmwxeUR/h1WQ6
         0G79E9u0y+eOEUxb5T+FGoVi4TOBQ68Kn/wuo9yp88nt1yqYCLNySz6UQ4jVFQntzd87
         crALesQAzNcesUDluoxaWb5wDwV/S6UxAecpuN1aZrVmLyI0b1xVG+3EzlRlMYbN3f3o
         lUwr92/y6g+2R/hbtY0pS8JtELUXHl3UiKNEejIbK0Z64IgNGRmSIRAOj/w804LShWIt
         xSYSs7Tv++RG2dX3UO7oN8TihFZGQzyV7AX7XScuuTUC3A7f/PwccXD9NdQNEUgt34SC
         4BQw==
X-Forwarded-Encrypted: i=1; AJvYcCUSjtmnpR0D3bjfBlCVqm4GH3q8zb7GF5Z9IbHoCClrz9Pmn3aNPHugz6j2plnPOi5+bC3psWwkXGQ2uMLjqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywAeAYUneGya99+EV2KSk8GOnQjt70grnDGuVb6k/1lZlCopPo
	aHrIsG91l2BKzQ4FRgxhdiO2AU08yS4N731z7FaS4bPZrtxvwDL65AF9RYXRkBcTkPYnTHPLJRT
	RJw92F8vmUMEumaiyNslr7lVKOY0jl4NBq7dabpkpCnNR4lmbweJRqIYmpPMI590a
X-Gm-Gg: ASbGncuBTLRACSUSZVSagjQWGuo82ppaZGvgKN03x1DzNTQ/S8l7KdiKm0IApVB5qO2
	WOCW072lIJ6Dg8xpVznNLpW7Zx0+9kpWV32+mA02iVhxZDsqDDJk7aSxUQ8fT99mnBkw23f/L6t
	r8GX0mPdzO47APClbkapwrStrhnxtDxnw4/qYl9G1JPclHiV8hYx+ntleK8vPtZJ5hM7iPiZsq8
	Ti8oVBRg5p0KkDy93OTLjXpPhOaWW/mYUpI/CebbyONS5llX+6e2iuLGKyKDBXhVFloc1GrMBfX
	Ts911WfPWtW/vcf63A==
X-Received: by 2002:a05:620a:1991:b0:7b6:6a76:3a44 with SMTP id af79cd13be357-7b6a5d52697mr767734785a.17.1733344374376;
        Wed, 04 Dec 2024 12:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaQqtfzRK5vt+ID0JbEu0ecyM3mIveMH1NkAxzJDB09gJ+/C/aicC519yjfZ6deJBjmKApAw==
X-Received: by 2002:a05:620a:1991:b0:7b6:6a76:3a44 with SMTP id af79cd13be357-7b6a5d52697mr767732985a.17.1733344374066;
        Wed, 04 Dec 2024 12:32:54 -0800 (PST)
Received: from thinkpad2024.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492ca67sm646047785a.35.2024.12.04.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:32:53 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2] tuna: Fix help.py syntax warnings
Date: Wed,  4 Dec 2024 15:31:58 -0500
Message-ID: <20241204203201.8145-1-jwyatt@redhat.com>
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
was after running ./tuna-cmd.py. The warnings do not appear most of the
time.

Regardless, these are an issue that can be trivally fixed so sending
a patch.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- Add my signoff.
	- Small correction: ./tuna-cmd.py
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

