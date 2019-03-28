Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADF5C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2610217D7
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="KgPPmeSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfC1MIi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:08:38 -0400
Received: from mail158c50.megamailservers.eu ([91.136.10.168]:36744 "EHLO
        mail51c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbfC1MIi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 08:08:38 -0400
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1553774909;
        bh=IvUUrPLDkcufvP5k07WbS8ANCv6puYxIYEsfo6K4USE=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=KgPPmeSgOPLEWUpTIWQCz3b/TqLCIxPpOG1QHpESEAS6MKuIckwD2b5SAYmAVxt2l
         bLtrWTVRapVZidKmYZPAC78kVGJWE5/btDYsqelrma2RfqozrtUbOSsg0SU6cXgVkB
         b64kLwGJj+7dqgedR3lYlSj5jzKMFSW7DxJoxJoM=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x5d845ab5.dyn.telefonica.de [93.132.90.181])
        (authenticated bits=0)
        by mail51c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x2SC8R8e021325
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2019 12:08:29 +0000
Date:   Thu, 28 Mar 2019 13:08:29 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190328130829.3a3bbe70@archlinux>
In-Reply-To: <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
        <20190328115559.275af3c3@archlinux>
        <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B0212.5C9CB93D.0084,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=a8seC3aF c=1 sm=1 tr=0 a=Fdxjfia4lOXO4wIx1HYRQQ==:117
        a=Fdxjfia4lOXO4wIx1HYRQQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=Br9LfDWDAAAA:8 a=i2fEqHxy_IivrJZb55MA:9
        a=CjuIK1q_8ugA:10 a=gR_RJRYUad_6_ruzA8cR:22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I don't have access to gitlab.manjaro, so I make a diff from the AUR
config (note, it still needs to pass make olddefconfig, so it might not
be the final config from AUR) and the config used by my kernel.

[rocketmouse@archlinux tmp]$ wget -q https://aur.archlinux.org/cgit/aur.git/snapshot/linux-rt.tar.gz
[rocketmouse@archlinux tmp]$ tar xf linux-rt.tar.gz
[rocketmouse@archlinux tmp]$ diff linux-rt/config /lib/modules/5.0.3-rt1-0-rt-pussytoes-0-rt/build/.config 
22,23c22,23
< CONFIG_LOCALVERSION=""
< CONFIG_LOCALVERSION_AUTO=y
---
> CONFIG_LOCALVERSION="-0-rt"
> # CONFIG_LOCALVERSION_AUTO is not set
37c37
< CONFIG_DEFAULT_HOSTNAME="archlinux"
---
> CONFIG_DEFAULT_HOSTNAME="archlinux-rt"
112,113c112
< CONFIG_PSI=y
< # CONFIG_PSI_DEFAULT_DISABLED is not set
---
> # CONFIG_PSI is not set
301c300
< CONFIG_X86_CPU_RESCTRL=y
---
> # CONFIG_X86_CPU_RESCTRL is not set
495c494
< CONFIG_ENERGY_MODEL=y
---
> # CONFIG_ENERGY_MODEL is not set
803c802
< # CONFIG_MODVERSIONS is not set
---
> CONFIG_MODVERSIONS=y
1160c1159
< CONFIG_NFT_XFRM=m
---
> # CONFIG_NFT_XFRM is not set
1494,1496d1492
< CONFIG_NET_DSA_TAG_GSWIP=y
< CONFIG_NET_DSA_TAG_KSZ=y
< CONFIG_NET_DSA_TAG_KSZ9477=y
1549c1545
< CONFIG_NET_SCH_TAPRIO=m
---
> # CONFIG_NET_SCH_TAPRIO is not set
1656c1652
< CONFIG_NCSI_OEM_CMD_GET_MAC=y
---
> # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
1705c1701
< CONFIG_CAN_FLEXCAN=m
---
> # CONFIG_CAN_FLEXCAN is not set
1953c1949
< CONFIG_PCI_P2PDMA=y
---
> # CONFIG_PCI_P2PDMA is not set
1989c1985
< CONFIG_PCI_MESON=y
---
> # CONFIG_PCI_MESON is not set
2142,2145c2138,2139
< CONFIG_MTD_PHYSMAP_OF=y
< CONFIG_MTD_PHYSMAP_VERSATILE=y
< CONFIG_MTD_PHYSMAP_GEMINI=y
< CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
---
> # CONFIG_MTD_PHYSMAP_OF is not set
> # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
2298c2292
< CONFIG_NVME_TCP=m
---
> # CONFIG_NVME_TCP is not set
2304c2298
< CONFIG_NVME_TARGET_TCP=m
---
> # CONFIG_NVME_TARGET_TCP is not set
2350c2344
< CONFIG_EEPROM_EE1004=m
---
> # CONFIG_EEPROM_EE1004 is not set
2413c2407
< CONFIG_MISC_ALCOR_PCI=m
---
> # CONFIG_MISC_ALCOR_PCI is not set
2505c2499
< CONFIG_SCSI_UFS_CDNS_PLATFORM=m
---
> # CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
2507c2501
< CONFIG_SCSI_UFS_BSG=y
---
> # CONFIG_SCSI_UFS_BSG is not set
2511,2512c2505,2506
< CONFIG_SCSI_MYRB=m
< CONFIG_SCSI_MYRS=m
---
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
2829c2823
< CONFIG_B53_SERDES=m
---
> # CONFIG_B53_SERDES is not set
2832c2826
< CONFIG_NET_DSA_LANTIQ_GSWIP=m
---
> # CONFIG_NET_DSA_LANTIQ_GSWIP is not set
2834,2836c2828
< CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
< CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
< CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
---
> # CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
2987c2979
< CONFIG_IGC=m
---
> # CONFIG_IGC is not set
3055c3047
< CONFIG_NI_XGE_MANAGEMENT_ENET=m
---
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
3285c3277
< CONFIG_USB_NET_AQC111=m
---
> # CONFIG_USB_NET_AQC111 is not set
3474c3466
< CONFIG_MT76x0E=m
---
> # CONFIG_MT76x0E is not set
3556,3557c3548
< CONFIG_QTNFMAC=m
< CONFIG_QTNFMAC_PCIE=m
---
> # CONFIG_QTNFMAC_PCIE is not set
3562c3553
< CONFIG_VIRT_WIFI=m
---
> # CONFIG_VIRT_WIFI is not set
4039c4030
< CONFIG_SERIO_OLPC_APSP=m
---
> # CONFIG_SERIO_OLPC_APSP is not set
4252c4243
< CONFIG_I2C_NVIDIA_GPU=m
---
> # CONFIG_I2C_NVIDIA_GPU is not set
4307,4309c4298
< CONFIG_I3C=m
< CONFIG_CDNS_I3C_MASTER=m
< CONFIG_DW_I3C_MASTER=m
---
> # CONFIG_I3C is not set
4337c4326
< CONFIG_SPI_MXIC=m
---
> # CONFIG_SPI_MXIC is not set
4400c4389
< CONFIG_PINCTRL_OCELOT=y
---
> # CONFIG_PINCTRL_OCELOT is not set
4432c4421
< CONFIG_GPIO_CADENCE=m
---
> # CONFIG_GPIO_CADENCE is not set
4444,4445c4433,4434
< CONFIG_GPIO_SAMA5D2_PIOBU=m
< CONFIG_GPIO_SIOX=m
---
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> # CONFIG_GPIO_SIOX is not set
4748,4750c4737
< CONFIG_SENSORS_OCC_P8_I2C=m
< CONFIG_SENSORS_OCC_P9_SBE=m
< CONFIG_SENSORS_OCC=y
---
> # CONFIG_SENSORS_OCC_P8_I2C is not set
4927c4914
< CONFIG_TQMX86_WDT=m
---
> # CONFIG_TQMX86_WDT is not set
5186c5173
< CONFIG_REGULATOR_MCP16502=m
---
> # CONFIG_REGULATOR_MCP16502 is not set
5230a5218
> CONFIG_CEC_PIN=y
5269c5257
< CONFIG_RC_XBOX_DVD=m
---
> # CONFIG_RC_XBOX_DVD is not set
5280a5269
> # CONFIG_CEC_PIN_ERROR_INJ is not set
5556c5545
< CONFIG_VIDEO_ASPEED=m
---
> # CONFIG_VIDEO_ASPEED is not set
5576,5578c5565,5566
< # CONFIG_CEC_GPIO is not set
< CONFIG_VIDEO_SECO_CEC=m
< CONFIG_VIDEO_SECO_RC=y
---
> CONFIG_CEC_GPIO=m
> # CONFIG_VIDEO_SECO_CEC is not set
6012c6000
< CONFIG_HSA_AMD=y
---
> # CONFIG_HSA_AMD is not set
6075c6063
< CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
---
> # CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
6080c6068
< CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
---
> # CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
6088c6076
< CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
---
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
6106c6094
< CONFIG_DRM_TOSHIBA_TC358764=m
---
> # CONFIG_DRM_TOSHIBA_TC358764 is not set
6109c6097
< CONFIG_DRM_TI_SN65DSI86=m
---
> # CONFIG_DRM_TI_SN65DSI86 is not set
6124c6112
< CONFIG_TINYDRM_HX8357D=m
---
> # CONFIG_TINYDRM_HX8357D is not set
6471c6459
< CONFIG_SND_SOC_AMD_ACP3x=m
---
> # CONFIG_SND_SOC_AMD_ACP3x is not set
6473c6461
< CONFIG_SND_SOC_MIKROE_PROTO=m
---
> # CONFIG_SND_SOC_MIKROE_PROTO is not set
6518c6506
< CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
---
> # CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
6542,6543c6530,6531
< CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
< CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
---
> # CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
6545d6532
< CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
6550c6537
< CONFIG_SND_SOC_XILINX_I2S=m
---
> # CONFIG_SND_SOC_XILINX_I2S is not set
6567c6554
< CONFIG_SND_SOC_AK4118=m
---
> # CONFIG_SND_SOC_AK4118 is not set
6610d6596
< CONFIG_SND_SOC_HDAC_HDA=m
6612c6598
< CONFIG_SND_SOC_MAX98088=m
---
> # CONFIG_SND_SOC_MAX98088 is not set
6631,6633c6617,6618
< CONFIG_SND_SOC_PCM3060=m
< CONFIG_SND_SOC_PCM3060_I2C=m
< CONFIG_SND_SOC_PCM3060_SPI=m
---
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3060_SPI is not set
6651d6635
< CONFIG_SND_SOC_RT5660=m
6719c6703
< CONFIG_SND_SOC_NAU8822=m
---
> # CONFIG_SND_SOC_NAU8822 is not set
6756c6740
< CONFIG_HID_BIGBEN_FF=m
---
> # CONFIG_HID_BIGBEN_FF is not set
7242c7226
< CONFIG_UCSI_CCG=m
---
> # CONFIG_UCSI_CCG is not set
7287d7270
< CONFIG_MMC_ALCOR=m
7303c7286
< CONFIG_MMC_SDHCI_AM654=m
---
> # CONFIG_MMC_SDHCI_AM654 is not set
7332c7315
< CONFIG_LEDS_AN30259A=m
---
> # CONFIG_LEDS_AN30259A is not set
7414c7397
< CONFIG_LEDS_TRIGGER_PATTERN=m
---
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
7660c7643
< CONFIG_UDMABUF=y
---
> # CONFIG_UDMABUF is not set
7948c7931
< CONFIG_VIDEO_IPU3_IMGU=m
---
> # CONFIG_VIDEO_IPU3_IMGU is not set
8026c8009
< CONFIG_LG_LAPTOP=m
---
> # CONFIG_LG_LAPTOP is not set
8084,8085c8067,8068
< CONFIG_INTEL_ATOMISP2_PM=m
< CONFIG_HUAWEI_WMI=m
---
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_HUAWEI_WMI is not set
8125c8108
< CONFIG_COMMON_CLK_BD718XX=m
---
> # CONFIG_COMMON_CLK_BD718XX is not set
8264,8266c8247,8248
< CONFIG_ADXL372=m
< CONFIG_ADXL372_SPI=m
< CONFIG_ADXL372_I2C=m
---
> # CONFIG_ADXL372_SPI is not set
> # CONFIG_ADXL372_I2C is not set
8305c8287
< CONFIG_AD7124=m
---
> # CONFIG_AD7124 is not set
8315c8297
< CONFIG_AD7949=m
---
> # CONFIG_AD7949 is not set
8338c8320
< CONFIG_MCP3911=m
---
> # CONFIG_MCP3911 is not set
8345c8327
< CONFIG_QCOM_SPMI_ADC5=m
---
> # CONFIG_QCOM_SPMI_ADC5 is not set
8421c8403
< CONFIG_LTC1660=m
---
> # CONFIG_LTC1660 is not set
8442c8424
< CONFIG_TI_DAC7311=m
---
> # CONFIG_TI_DAC7311 is not set
8571c8553
< CONFIG_VCNL4035=m
---
> # CONFIG_VCNL4035 is not set
8594,8596c8576,8577
< CONFIG_SENSORS_RM3100=m
< CONFIG_SENSORS_RM3100_I2C=m
< CONFIG_SENSORS_RM3100_SPI=m
---
> # CONFIG_SENSORS_RM3100_I2C is not set
> # CONFIG_SENSORS_RM3100_SPI is not set
8627c8608
< CONFIG_MCP41010=m
---
> # CONFIG_MCP41010 is not set
8676c8657
< CONFIG_VL53L0X_I2C=m
---
> # CONFIG_VL53L0X_I2C is not set
8759,8761c8740,8742
< CONFIG_PHY_CADENCE_DP=m
< CONFIG_PHY_CADENCE_SIERRA=m
< CONFIG_PHY_FSL_IMX8MQ_USB=m
---
> # CONFIG_PHY_CADENCE_DP is not set
> # CONFIG_PHY_CADENCE_SIERRA is not set
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
8766c8747
< CONFIG_PHY_OCELOT_SERDES=m
---
> # CONFIG_PHY_OCELOT_SERDES is not set
8808,8809c8789,8790
< CONFIG_STM_PROTO_BASIC=m
< CONFIG_STM_PROTO_SYS_T=m
---
> # CONFIG_STM_PROTO_BASIC is not set
> # CONFIG_STM_PROTO_SYS_T is not set
8847c8828
< CONFIG_FSI_OCC=m
---
> # CONFIG_FSI_OCC is not set
9042c9023
< CONFIG_UBIFS_FS_AUTHENTICATION=y
---
> # CONFIG_UBIFS_FS_AUTHENTICATION is not set
9345c9326
< CONFIG_CRYPTO_ECB=m
---
> CONFIG_CRYPTO_ECB=y
9347c9328
< CONFIG_CRYPTO_OFB=m
---
> # CONFIG_CRYPTO_OFB is not set
9351,9354c9332,9334
< CONFIG_CRYPTO_NHPOLY1305=m
< CONFIG_CRYPTO_NHPOLY1305_SSE2=m
< CONFIG_CRYPTO_NHPOLY1305_AVX2=m
< CONFIG_CRYPTO_ADIANTUM=m
---
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
9391c9371
< CONFIG_CRYPTO_STREEBOG=m
---
> # CONFIG_CRYPTO_STREEBOG is not set
9489c9469
< CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
---
> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
9491,9492c9471
< CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
< CONFIG_TPM_KEY_PARSER=m
---
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
9737a9717
> CONFIG_TRACE_IRQFLAGS=y
9777a9758
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
9784c9765,9766
< # CONFIG_PREEMPTIRQ_EVENTS is not set
---
> CONFIG_TRACE_PREEMPT_TOGGLE=y
> CONFIG_PREEMPTIRQ_EVENTS=y

FWIW I didn't use this kernel for real-time audio work, it was only
used for averaged desktop work.

At the moment I'm using

[rocketmouse@archlinux tmp]$ uname -rm
4.19.31-rt18-0-rt-securityink x86_64

also not for real-time related work, just for office stuff.

Regards,
Ralf

-- 
pacman -Q linux{,-rt{-pussytoes,-securityink,-cornflower,}}|cut -d\  -f2
5.0.4.arch1-1
5.0.3_rt1-0
4.19.31_rt18-0
4.19.25_rt16-0
4.19.23_rt13-0.1
