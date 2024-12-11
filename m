Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32461F9406
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943700; cv=none; b=ac6V067eKAvnmA1asJLcgmX8cuSDYL1qWzngpY9ISVPHAdt1U7NeNn+uf3Q2cduYaLizBxYoZyzy6AnxrFYGAJ+E0i3Cnet2SAOd5PqqphxYBuQdCX4GoIU1+Z3niQ6+wiFgYlLAGObO0cs7q+5bQvUytBBlse8tPYyhrIYNECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943700; c=relaxed/simple;
	bh=s9x9oNXgmRe1ic9hn5eROBSKgyJmcW0p6Fh/++U4DOs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BlgcIFBWEwXSNy3jncotx5noXYq0kFqpOsy/Nkxh4ejtmu8EP5SWrsIncWY1oxdTnj+Jgk6mFSFR0lMFmbPKCITJAJN6RX0Rp+/N5c4FEV6gUFURuUQe6avtF7yTxcHCxQw7lSsqE2NoMnTAfOM9T7Xt4yURkUfux2ijbYcqfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li+ZZvj5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li+ZZvj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733943697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TSFWWB1Nyo5hCb6p0HOvNqEwrDz2uEDBEpQAgDfK+ck=;
	b=Li+ZZvj5Za1e+tKkWSW1NUmmGkCXc2AmydDSCSv+KFIhsOmQ5EwOax7AlEns4j+luJLTYM
	lOjNv+JW5Nm94Ey85RdB9yFD7WznShzTTwHp19NZywAOtwwQZ3yjbbL6fZ7hKwZOgBrFu6
	Z7gQ+WaJUCrsjrgjdA6rFZtMiWxV5EY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-R7BIUVa1PL2Y8u0ZFQHV5A-1; Wed, 11 Dec 2024 14:01:35 -0500
X-MC-Unique: R7BIUVa1PL2Y8u0ZFQHV5A-1
X-Mimecast-MFC-AGG-ID: R7BIUVa1PL2Y8u0ZFQHV5A
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d92efa9ff4so28551136d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 11:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733943694; x=1734548494;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSFWWB1Nyo5hCb6p0HOvNqEwrDz2uEDBEpQAgDfK+ck=;
        b=gEp27imnOba5jR56owz+Yr/FM1t5JYk/1TICb5GD0lIFv7m/BDpn3IAsOoXkAgYzfT
         icS+xGNfqWvrPOLh6UNCwi5fA53vc7tm86DA3vfajf0WCTvPrCSWJd4q29PcE91ya2+0
         YWbi1r/KOgwj4XkvAhg8L/pPpMQelv3q7DSLx8wEqMDItwg2AkpQCdl92aJAFDsI2Rju
         yWj5Mb0kT2kbECPnylFCthBmAShwrtxf7KVtXP0TdXEfrA2WU7i4ffQx60Obf4KEGd5H
         qYL+vBW2KXbicmmOULyClfnD27k0UK+5XiqglFQCNzZ/JVyxsmCyg23iN//c0Cc9aMJG
         zlcg==
X-Forwarded-Encrypted: i=1; AJvYcCVtFZrcatGaLzjg2SFqDCm5Zbg7Ruk9JHH7o5KSQk0gIzqdedpjwNBrIJdFPsQrehIqhIFq5HTKYpCCVLmDOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIb6DDtwz1pdwPJfeYiicSJ3BGxjcZrkueLXWrcGoWM0Q5LItn
	5/Ppcs2OEuDCgrHQy8PMR4HbZ7dxMEDHmUFaBzpnjT9Xu1cpbPccOjqzpSUe8hLaaqF6x0zeATQ
	WkNboEWAkSTFOpRUtBC8Ah4w30rS8N70VC2SyDACbDiuNLLzpea3iMrq07ACJy6fnb4XJ5ln2
X-Gm-Gg: ASbGncu1TIlHcalUYV52ITWEAvtx5b/4T4/sCuANQKWtSiDdFXJ2n5SShUAPSEXZiQl
	mKUau6Ua0QGSW6tctvMde28611GvfI9VmLZnnyHkh+YY8EWlNyKBLn3QBoauhpovzKZYy+ZEWgX
	7XUCI5mglaIcLSJO7H3A6rM7zbScv5plPxfwmmKgTU+t3Qrl3kC9YJlMGsmsLU1+Ka6uVoZuHFf
	cTbXHp9n7FwAI0Re3gU4ieg4OkaeI8eINKMFTfFUkFY
X-Received: by 2002:a05:6214:501a:b0:6d8:96a6:ec22 with SMTP id 6a1803df08f44-6dae3928105mr6839646d6.23.1733943694336;
        Wed, 11 Dec 2024 11:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCz+sInGe00jEeCfqQYbA8S/YUYqwg28VsMBzo/3M6EAhgmODmRjRQREXKpX0LmeBy4I3KnA==
X-Received: by 2002:a05:6214:501a:b0:6d8:96a6:ec22 with SMTP id 6a1803df08f44-6dae3928105mr6839366d6.23.1733943694053;
        Wed, 11 Dec 2024 11:01:34 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6966desm73033666d6.41.2024.12.11.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:01:33 -0800 (PST)
Date: Wed, 11 Dec 2024 14:01:32 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v2] tuna: Fix help.py syntax warnings
In-Reply-To: <20241204203201.8145-1-jwyatt@redhat.com>
Message-ID: <66e0ea75-d388-ae24-cc2c-f9016c85836f@redhat.com>
References: <20241204203201.8145-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 4 Dec 2024, John B. Wyatt IV wrote:

> Fix two syntax warnings with what looks like should have been a new line
> like the other help entries.
> 
> I am struggling to reproduce the scenario that caused them despite it
> was after running ./tuna-cmd.py. The warnings do not appear most of the
> time.
> 
> Regardless, these are an issue that can be trivally fixed so sending
> a patch.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
-edited commit message
Signed-off-by: John Kacur
---
Please don't include what should be a discussion in your patch,
just tell us what problem you are fixing, and how if it isn't obvious

Thank you

John



> ---
> 
> Changes in v2:
> 	- Add my signoff.
> 	- Small correction: ./tuna-cmd.py
> ---
>  tuna/help.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tuna/help.py b/tuna/help.py
> index fa47ae8..c913a16 100644
> --- a/tuna/help.py
> +++ b/tuna/help.py
> @@ -44,7 +44,7 @@ PROC_SYS_HELP = {
>  	'net.core.rmem_default':N_('The default setting of the socket receive buffer in bytes.'),
>  	'net.core.rmem_max':N_('The maximum receive socket buffer size in bytes.'),
>  	'net.core.rps_sock_flow_entries':N_('This controls the maximum number of sockets/flows that the kernel can steer towards any specified CPU. This is a system-wide, shared limit.'),
> -	'net.core.somaxconn':N_('Limit of socket listen() backlog, known in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuning for TCP sockets.\Default: 128.'),
> +	'net.core.somaxconn':N_('Limit of socket listen() backlog, known in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuning for TCP sockets.\nDefault: 128.'),
>  	'net.core.warnings':N_('This controls console messages from the networking stack that can occur because of problems on the network like duplicate address or bad checksums. Normally, this should be enabled, but if the problem persists the messages can be disabled.'),
>  	'net.core.wmem_default':N_('The default setting (in bytes) of the socket send buffer.'),
>  	'net.core.wmem_max':N_('The maximum send socket buffer size in bytes.'),
> @@ -118,7 +118,7 @@ PROC_SYS_HELP = {
>  	'net.ipv4.tcp_reordering':N_('Maximal reordering of packets in a TCP stream.\nDefault: 3'),
>  	'net.ipv4.tcp_retrans_collapse':N_('Bug-to-bug compatibility with some broken printers. On retransmit try to send bigger packets to work around bugs in certain TCP stacks.'),
>  	'net.ipv4.tcp_retries1':N_('This value influences the time, after which TCP decides, that something is wrong due to unacknowledged RTO retransmissions, and reports this suspicion to the network layer.\nRFC 1122 recommends at least 3 retransmissions, which is the default.\nDefault: 3'),
> -	'net.ipv4.tcp_retries2':N_('This value influences the timeout of an alive TCP connection, when RTO retransmissions remain unacknowledged. Given a value of N, a hypothetical TCP connection following exponential backoff with an initial RTO of TCP_RTO_MIN would retransmit N times before killing the connection at the (N+1)th RTO. The default value of 15 yields a hypothetical timeout of 924.6 seconds and is a lower bound for the effective timeout. TCP will effectively time out at the first RTO which exceeds the hypothetical timeout. RFC 1122 recommends at least 100 seconds for the timeout,	which corresponds to a value of at least 8.\Default: 8'),
> +	'net.ipv4.tcp_retries2':N_('This value influences the timeout of an alive TCP connection, when RTO retransmissions remain unacknowledged. Given a value of N, a hypothetical TCP connection following exponential backoff with an initial RTO of TCP_RTO_MIN would retransmit N times before killing the connection at the (N+1)th RTO. The default value of 15 yields a hypothetical timeout of 924.6 seconds and is a lower bound for the effective timeout. TCP will effectively time out at the first RTO which exceeds the hypothetical timeout. RFC 1122 recommends at least 100 seconds for the timeout,	which corresponds to a value of at least 8.\nDefault: 8'),
>  	'net.ipv4.tcp_rfc1337':N_('If set, the TCP stack behaves conforming to RFC1337. If unset, we are not conforming to RFC, but prevent TCP TIME_WAIT assassination.\nDefault: 0'),
>  	'net.ipv4.tcp_rmem':N_('Vector of 3 values: min, default, max\n - min: Minimal size of receive buffer used by TCP sockets. It is guaranteed to each TCP socket, even under moderate memory pressure.\nDefault: 8K\n - default: initial size of receive buffer used by TCP sockets. This value overrides net.core.rmem_default used by other protocols. Default: 87380 bytes. This value results in window of 65535 with default setting of tcp_adv_win_scale and tcp_app_win:0 and a bit less for default tcp_app_win. See below about these variables. - max: maximal size of receive buffer allowed for automatically selected receiver buffers for TCP socket. This value does not override net.core.rmem_max.  Calling setsockopt() with SO_RCVBUF disables automatic tuning of that socket\'s receive buffer size, in which case this value is ignored.\nDefault: between 87380B and 4MB, depending on RAM size.'),
>  	'net.ipv4.tcp_sack':N_('Enable select acknowledgments (SACKS).'),
> -- 
> 2.47.0
> 
> 
> 

