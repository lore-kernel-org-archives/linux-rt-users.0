Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBE223C51
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018502; cv=none; b=K9DQv93WLzX6sti2sneXBhccZfHvmJJHR5VqIvXAVLsRZQfT5ZshHZn+j0AomufK1haM74XDzGxEZ2555rvgvNs+cgAQuIogivXyfT6Udfg/VlUCCnogrxGwLP60kly7pDYflG+z4h202Fxm15BH209i9Cd+ei4DFiYWwX2Yq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018502; c=relaxed/simple;
	bh=qJSaahmlH8dkbSwdTJDD6NN135Rqr+Fs3bKK2BOCPiY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LPyUuvPEALdETlspFROH7psLTj4iFFUTjVC24hkrfWZaU59hYmGqfsiMzrl5lLLmfVrajnpIsVjdRRcOdgta1pOg0oJ20AgvuI7D80tGosS2IT734EkHmhcWIJGjS6cpMuO8ir1Oj7nX9hsSO2TCzLkBuz1oYwuAjra07T3o2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHjPoWLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHjPoWLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734018498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVUUo5+kwvUTuGq9P94MyFUkoyGLLZPbb8nLa8W+zTw=;
	b=SHjPoWLdhkb4d4exFlv5MqmVDYT3YqkmDMT8ap117+ZLDZkk3lCzrd6CK4xDIqe+7l/VWG
	5xtosEpTomtPB0hn1vkodIhXZSPTD4KBpUXnmAg00Z5j+77FXRqOGR1eeXGF4eshVZXD02
	ZOAQ/4I/x0tnfWpDE47CAngeu9OfYag=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-_AXQzs-mOP2_ns7bYtLHkw-1; Thu, 12 Dec 2024 10:48:17 -0500
X-MC-Unique: _AXQzs-mOP2_ns7bYtLHkw-1
X-Mimecast-MFC-AGG-ID: _AXQzs-mOP2_ns7bYtLHkw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f51b49e5so14644126d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 07:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018496; x=1734623296;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVUUo5+kwvUTuGq9P94MyFUkoyGLLZPbb8nLa8W+zTw=;
        b=EPlN+slZfNnMUDix1kU0ICxEVMWh0zGM7hkh02KP3XIr0YGtGFDwsTsY2ZeLpwZXHU
         PPKoo6pWtAJhXhGi1Y7hHz7LcQzyOWlolUlC10IwjzmvSLRmlWsmpKrVsxPHnirR9ldQ
         RD1P+8rDV4Igsqiwy2R2OordEc2HrsK0v9F9IO3CekJEFHZGkDnQYRDoqPA8x0l1xJvg
         gkatrqiDP9pNljt8dUi6BSPIgLGqn/TsGYgG48svwzH2diRCucQ0atXVdiUe23eb0Reo
         4mkl9+vrFdpTg2ODP/EFaOLcTVJRJZq6Es6PDfocwlPKBQHBUs8bfPaXiTASkkhk6c5v
         wk4g==
X-Gm-Message-State: AOJu0Yxwc6zZQXGw/3B6i59gs7eaCNP/uOMSFxN0a22XsD4P+0VFJGUS
	M+dM51iZilOZkPcMySYc9gK1dvlvl0JbESuqZ/PRylxnJWFqphQ14a57kLPMN73FCC2KjWFEPD6
	6dwzHg5a/GVB5EUU219wsmP2wqSIQyPZCVbzdjLTFWkjakQuE1tIoRG8k7mGwgFhR+r3/yUg+
X-Gm-Gg: ASbGncuzF90oCw/2tMSbO92lBOcMQVJjKv0GYw+IORsKA8PfWSrs60bgzgRS3tr5t2g
	ZM1WhWQcM7xhuLhV4y1KE4AZeHE/FzzekkhwzxJgPnTIcleNn4wA6kcBTlYW6VMp309F0HHFwBz
	GWZXKhAGEtIAiaDjXYaijf/sBUSvehK9QFWYNRp0nMdl3PKkeyLCcswKXhTv+41Pe+lxodPIxNK
	9v/EZZIJUCO00JnCZynNzqr/TcXWw15NKnE5niVsViBH1E=
X-Received: by 2002:a05:6214:2405:b0:6d4:287d:b8d6 with SMTP id 6a1803df08f44-6db0f7334d4mr14608176d6.18.1734018496716;
        Thu, 12 Dec 2024 07:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPix9C8uCaj6LZMikkfSHUwHn+pJx/n6e5nZyKYbsbiwaBlM8LktHdIf+mt7M7yJz9DNc2YQ==
X-Received: by 2002:a05:6214:2405:b0:6d4:287d:b8d6 with SMTP id 6a1803df08f44-6db0f7334d4mr14607716d6.18.1734018496300;
        Thu, 12 Dec 2024 07:48:16 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dae0f64eafsm13407676d6.100.2024.12.12.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:48:15 -0800 (PST)
Date: Thu, 12 Dec 2024 10:48:14 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: EnDe Tan <ende.tan@starfivetech.com>
cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
    "mtosatti@redhat.com" <mtosatti@redhat.com>, 
    "williams@redhat.com" <williams@redhat.com>, 
    Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
    "endeneer@gmail.com" <endeneer@gmail.com>
Subject: RE: [1/1] rt-tests: determine_maximum_mpps.sh: Introduce '-F' option
 to specify CPU frequency
In-Reply-To: <NT0PR01MB1024694086DE4C6265BF22DEF83FA@NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn>
Message-ID: <39f55b99-a8c7-5941-ee82-442e2cd9ead7@redhat.com>
References: <20241211171158.1344674-1-ende.tan@starfivetech.com> <dd8872e6-2278-b77b-7b98-2c69fbc7270e@redhat.com> <NT0PR01MB1024694086DE4C6265BF22DEF83FA@NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 12 Dec 2024, EnDe Tan wrote:

> > Are there other places to get this information, for example
> > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
> It is possible to specify "clock-frequency" in CPU nodes in device tree,
> which corresponds to entry like this
> /sys/devices/system/cpu/cpu0/of_node/clock-frequency
> 
> However, it's not mandatory to specify "clock-frequency", so maybe
> adding a '-F' option is more useful.
> 
> 
But why we would want to allow the user to specify a potentially arbitrary 
number, when we can get a more accurate one from the OS?

Do you have any comments Marcelo?

John

