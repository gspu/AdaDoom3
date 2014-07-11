package Neo.Link.Vorbis
  is
  end Neo.Link.Vorbis;
--  #ifndef _vorbis_codec_h_
--  #define _vorbis_codec_h_
--
--  #ifdef __cplusplus
--  extern "C"
--  {
--  #endif /* __cplusplus */
--
--  #include <ogg/ogg.h>
--
--  typedef struct vorbis_info{
--    int version;
--    int channels;
--    long rate;
--
--    /* The below bitrate declarations are *hints*.
--       Combinations of the three values carry the following implications:
--
--       all three set to the same value:
--         implies a fixed rate bitstream
--       only nominal set:
--         implies a VBR stream that averages the nominal bitrate.  No hard
--         upper/lower limit
--       upper and or lower set:
--         implies a VBR bitstream that obeys the bitrate limits. nominal
--         may also be set to give a nominal rate.
--       none set:
--         the coder does not care to speculate.
--    */
--
--    long bitrate_upper;
--    long bitrate_nominal;
--    long bitrate_lower;
--    long bitrate_window;
--
--    void *codec_setup;
--  } vorbis_info;
--
--  /* vorbis_dsp_state buffers the current vorbis audio
--     analysis/synthesis state.  The DSP state belongs to a specific
--     logical bitstream ****************************************************/
--  typedef struct vorbis_dsp_state{
--    int analysisp;
--    vorbis_info *vi;
--
--    float **pcm;
--    float **pcmret;
--    int      pcm_storage;
--    int      pcm_current;
--    int      pcm_returned;
--
--    int  preextrapolate;
--    int  eofflag;
--
--    long lW;
--    long W;
--    long nW;
--    long centerW;
--
--    ogg_int64_t granulepos;
--    ogg_int64_t sequence;
--
--    ogg_int64_t glue_bits;
--    ogg_int64_t time_bits;
--    ogg_int64_t floor_bits;
--    ogg_int64_t res_bits;
--
--    void       *backend_state;
--  } vorbis_dsp_state;
--
--  typedef struct vorbis_block{
--    /* necessary stream state for linking to the framing abstraction */
--    float  **pcm;       /* this is a pointer into local storage */
--    oggpack_buffer opb;
--
--    long  lW;
--    long  W;
--    long  nW;
--    int   pcmend;
--    int   mode;
--
--    int         eofflag;
--    ogg_int64_t granulepos;
--    ogg_int64_t sequence;
--    vorbis_dsp_state *vd; /* For read-only access of configuration */
--
--    /* local storage to avoid remallocing; it's up to the mapping to
--       structure it */
--    void               *localstore;
--    long                localtop;
--    long                localalloc;
--    long                totaluse;
--    struct alloc_chain *reap;
--
--    /* bitmetrics for the frame */
--    long glue_bits;
--    long time_bits;
--    long floor_bits;
--    long res_bits;
--
--    void *internal;
--
--  } vorbis_block;
--
--  /* vorbis_block is a single block of data to be processed as part of
--  the analysis/synthesis stream; it belongs to a specific logical
--  bitstream, but is independent from other vorbis_blocks belonging to
--  that logical bitstream. *************************************************/
--
--  struct alloc_chain{
--    void *ptr;
--    struct alloc_chain *next;
--  };
--
--  /* vorbis_info contains all the setup information specific to the
--     specific compression/decompression mode in progress (eg,
--     psychoacoustic settings, channel setup, options, codebook
--     etc). vorbis_info and substructures are in backends.h.
--  *********************************************************************/
--
--  /* the comments are not part of vorbis_info so that vorbis_info can be
--     static storage */
--  typedef struct vorbis_comment{
--    /* unlimited user comment fields.  libvorbis writes 'libvorbis'
--       whatever vendor is set to in encode */
--    char **user_comments;
--    int   *comment_lengths;
--    int    comments;
--    char  *vendor;
--
--  } vorbis_comment;
--
--
--  /* libvorbis encodes in two abstraction layers; first we perform DSP
--     and produce a packet (see docs/analysis.txt).  The packet is then
--     coded into a framed OggSquish bitstream by the second layer (see
--     docs/framing.txt).  Decode is the reverse process; we sync/frame
--     the bitstream and extract individual packets, then decode the
--     packet back into PCM audio.
--
--     The extra framing/packetizing is used in streaming formats, such as
--     files.  Over the net (such as with UDP), the framing and
--     packetization aren't necessary as they're provided by the transport
--     and the streaming layer is not used */
--
--  /* Vorbis PRIMITIVES: general ***************************************/
--
--  extern void     vorbis_info_init(vorbis_info *vi);
--  extern void     vorbis_info_clear(vorbis_info *vi);
--  extern int      vorbis_info_blocksize(vorbis_info *vi,int zo);
--  extern void     vorbis_comment_init(vorbis_comment *vc);
--  extern void     vorbis_comment_add(vorbis_comment *vc, const char *comment);
--  extern void     vorbis_comment_add_tag(vorbis_comment *vc,
--                                         const char *tag, const char *contents);
--  extern char    *vorbis_comment_query(vorbis_comment *vc, const char *tag, int count);
--  extern int      vorbis_comment_query_count(vorbis_comment *vc, const char *tag);
--  extern void     vorbis_comment_clear(vorbis_comment *vc);
--
--  extern int      vorbis_block_init(vorbis_dsp_state *v, vorbis_block *vb);
--  extern int      vorbis_block_clear(vorbis_block *vb);
--  extern void     vorbis_dsp_clear(vorbis_dsp_state *v);
--  extern double   vorbis_granule_time(vorbis_dsp_state *v,
--                                      ogg_int64_t granulepos);
--
--  extern const char *vorbis_version_string(void);
--
--  /* Vorbis PRIMITIVES: analysis/DSP layer ****************************/
--
--  extern int      vorbis_analysis_init(vorbis_dsp_state *v,vorbis_info *vi);
--  extern int      vorbis_commentheader_out(vorbis_comment *vc, ogg_packet *op);
--  extern int      vorbis_analysis_headerout(vorbis_dsp_state *v,
--                                            vorbis_comment *vc,
--                                            ogg_packet *op,
--                                            ogg_packet *op_comm,
--                                            ogg_packet *op_code);
--  extern float  **vorbis_analysis_buffer(vorbis_dsp_state *v,int vals);
--  extern int      vorbis_analysis_wrote(vorbis_dsp_state *v,int vals);
--  extern int      vorbis_analysis_blockout(vorbis_dsp_state *v,vorbis_block *vb);
--  extern int      vorbis_analysis(vorbis_block *vb,ogg_packet *op);
--
--  extern int      vorbis_bitrate_addblock(vorbis_block *vb);
--  extern int      vorbis_bitrate_flushpacket(vorbis_dsp_state *vd,
--                                             ogg_packet *op);
--
--  /* Vorbis PRIMITIVES: synthesis layer *******************************/
--  extern int      vorbis_synthesis_idheader(ogg_packet *op);
--  extern int      vorbis_synthesis_headerin(vorbis_info *vi,vorbis_comment *vc,
--                                            ogg_packet *op);
--
--  extern int      vorbis_synthesis_init(vorbis_dsp_state *v,vorbis_info *vi);
--  extern int      vorbis_synthesis_restart(vorbis_dsp_state *v);
--  extern int      vorbis_synthesis(vorbis_block *vb,ogg_packet *op);
--  extern int      vorbis_synthesis_trackonly(vorbis_block *vb,ogg_packet *op);
--  extern int      vorbis_synthesis_blockin(vorbis_dsp_state *v,vorbis_block *vb);
--  extern int      vorbis_synthesis_pcmout(vorbis_dsp_state *v,float ***pcm);
--  extern int      vorbis_synthesis_lapout(vorbis_dsp_state *v,float ***pcm);
--  extern int      vorbis_synthesis_read(vorbis_dsp_state *v,int samples);
--  extern long     vorbis_packet_blocksize(vorbis_info *vi,ogg_packet *op);
--
--  extern int      vorbis_synthesis_halfrate(vorbis_info *v,int flag);
--  extern int      vorbis_synthesis_halfrate_p(vorbis_info *v);
--
--  /* Vorbis ERRORS and return codes ***********************************/
--
--  #define OV_FALSE      -1
--  #define OV_EOF        -2
--  #define OV_HOLE       -3
--
--  #define OV_EREAD      -128
--  #define OV_EFAULT     -129
--  #define OV_EIMPL      -130
--  #define OV_EINVAL     -131
--  #define OV_ENOTVORBIS -132
--  #define OV_EBADHEADER -133
--  #define OV_EVERSION   -134
--  #define OV_ENOTAUDIO  -135
--  #define OV_EBADPACKET -136
--  #define OV_EBADLINK   -137
--  #define OV_ENOSEEK    -138
--
--  #ifdef __cplusplus
--  }
--  #endif /* __cplusplus */
--
--  #endif
--
--  #ifndef _OV_ENC_H_
--  #define _OV_ENC_H_
--
--  #ifdef __cplusplus
--  extern "C"
--  {
--  #endif /* __cplusplus */
--
--  #include "codec.h"
--
--  /**
--   * This is the primary function within libvorbisenc for setting up managed
--   * bitrate modes.
--   *
--   * Before this function is called, the \ref vorbis_info
--   * struct should be initialized by using vorbis_info_init() from the libvorbis
--   * API.  After encoding, vorbis_info_clear() should be called.
--   *
--   * The max_bitrate, nominal_bitrate, and min_bitrate settings are used to set
--   * constraints for the encoded file.  This function uses these settings to
--   * select the appropriate encoding mode and set it up.
--   *
--   * \param vi               Pointer to an initialized \ref vorbis_info struct.
--   * \param channels         The number of channels to be encoded.
--   * \param rate             The sampling rate of the source audio.
--   * \param max_bitrate      Desired maximum bitrate (limit). -1 indicates unset.
--   * \param nominal_bitrate  Desired average, or central, bitrate. -1 indicates unset.
--   * \param min_bitrate      Desired minimum bitrate. -1 indicates unset.
--   *
--   * \return Zero for success, and negative values for failure.
--   *
--   * \retval 0          Success.
--   * \retval OV_EFAULT  Internal logic fault; indicates a bug or heap/stack corruption.
--   * \retval OV_EINVAL  Invalid setup request, eg, out of range argument.
--   * \retval OV_EIMPL   Unimplemented mode; unable to comply with bitrate request.
--   */
--  extern int vorbis_encode_init(vorbis_info *vi,
--                                long channels,
--                                long rate,
--
--                                long max_bitrate,
--                                long nominal_bitrate,
--                                long min_bitrate);
--
--  /**
--   * This function performs step-one of a three-step bitrate-managed encode
--   * setup.  It functions similarly to the one-step setup performed by \ref
--   * vorbis_encode_init but allows an application to make further encode setup
--   * tweaks using \ref vorbis_encode_ctl before finally calling \ref
--   * vorbis_encode_setup_init to complete the setup process.
--   *
--   * Before this function is called, the \ref vorbis_info struct should be
--   * initialized by using vorbis_info_init() from the libvorbis API.  After
--   * encoding, vorbis_info_clear() should be called.
--   *
--   * The max_bitrate, nominal_bitrate, and min_bitrate settings are used to set
--   * constraints for the encoded file.  This function uses these settings to
--   * select the appropriate encoding mode and set it up.
--   *
--   * \param vi                Pointer to an initialized vorbis_info struct.
--   * \param channels          The number of channels to be encoded.
--   * \param rate              The sampling rate of the source audio.
--   * \param max_bitrate       Desired maximum bitrate (limit). -1 indicates unset.
--   * \param nominal_bitrate   Desired average, or central, bitrate. -1 indicates unset.
--   * \param min_bitrate       Desired minimum bitrate. -1 indicates unset.
--   *
--   * \return Zero for success, and negative for failure.
--   *
--   * \retval 0           Success
--   * \retval OV_EFAULT   Internal logic fault; indicates a bug or heap/stack corruption.
--   * \retval OV_EINVAL   Invalid setup request, eg, out of range argument.
--   * \retval OV_EIMPL    Unimplemented mode; unable to comply with bitrate request.
--   */
--  extern int vorbis_encode_setup_managed(vorbis_info *vi,
--                                         long channels,
--                                         long rate,
--
--                                         long max_bitrate,
--                                         long nominal_bitrate,
--                                         long min_bitrate);
--
--  /**
--   * This function performs step-one of a three-step variable bitrate
--   * (quality-based) encode setup.  It functions similarly to the one-step setup
--   * performed by \ref vorbis_encode_init_vbr() but allows an application to
--   * make further encode setup tweaks using \ref vorbis_encode_ctl() before
--   * finally calling \ref vorbis_encode_setup_init to complete the setup
--   * process.
--   *
--   * Before this function is called, the \ref vorbis_info struct should be
--   * initialized by using \ref vorbis_info_init() from the libvorbis API.  After
--   * encoding, vorbis_info_clear() should be called.
--   *
--   * \param vi        Pointer to an initialized vorbis_info struct.
--   * \param channels  The number of channels to be encoded.
--   * \param rate      The sampling rate of the source audio.
--   * \param quality   Desired quality level, currently from -0.1 to 1.0 (lo to hi).
--   *
--   * \return Zero for success, and negative values for failure.
--   *
--   * \retval  0          Success
--   * \retval  OV_EFAULT  Internal logic fault; indicates a bug or heap/stack corruption.
--   * \retval  OV_EINVAL  Invalid setup request, eg, out of range argument.
--   * \retval  OV_EIMPL   Unimplemented mode; unable to comply with quality level request.
--   */
--  extern int vorbis_encode_setup_vbr(vorbis_info *vi,
--                                    long channels,
--                                    long rate,
--
--                                    float quality
--                                    );
--
--  /**
--   * This is the primary function within libvorbisenc for setting up variable
--   * bitrate ("quality" based) modes.
--   *
--   *
--   * Before this function is called, the vorbis_info struct should be
--   * initialized by using vorbis_info_init() from the libvorbis API. After
--   * encoding, vorbis_info_clear() should be called.
--   *
--   * \param vi           Pointer to an initialized vorbis_info struct.
--   * \param channels     The number of channels to be encoded.
--   * \param rate         The sampling rate of the source audio.
--   * \param base_quality Desired quality level, currently from -0.1 to 1.0 (lo to hi).
--   *
--   *
--   * \return Zero for success, or a negative number for failure.
--   *
--   * \retval 0           Success
--   * \retval OV_EFAULT   Internal logic fault; indicates a bug or heap/stack corruption.
--   * \retval OV_EINVAL   Invalid setup request, eg, out of range argument.
--   * \retval OV_EIMPL    Unimplemented mode; unable to comply with quality level request.
--   */
--  extern int vorbis_encode_init_vbr(vorbis_info *vi,
--                                    long channels,
--                                    long rate,
--
--                                    float base_quality
--                                    );
--
--  /**
--   * This function performs the last stage of three-step encoding setup, as
--   * described in the API overview under managed bitrate modes.
--   *
--   * Before this function is called, the \ref vorbis_info struct should be
--   * initialized by using vorbis_info_init() from the libvorbis API, one of
--   * \ref vorbis_encode_setup_managed() or \ref vorbis_encode_setup_vbr() called to
--   * initialize the high-level encoding setup, and \ref vorbis_encode_ctl()
--   * called if necessary to make encoding setup changes.
--   * vorbis_encode_setup_init() finalizes the highlevel encoding structure into
--   * a complete encoding setup after which the application may make no further
--   * setup changes.
--   *
--   * After encoding, vorbis_info_clear() should be called.
--   *
--   * \param vi Pointer to an initialized \ref vorbis_info struct.
--   *
--   * \return Zero for success, and negative values for failure.
--   *
--   * \retval  0           Success.
--   * \retval  OV_EFAULT  Internal logic fault; indicates a bug or heap/stack corruption.
--   *
--   * \retval OV_EINVAL   Attempt to use vorbis_encode_setup_init() without first
--   * calling one of vorbis_encode_setup_managed() or vorbis_encode_setup_vbr() to
--   * initialize the high-level encoding setup
--   *
--   */
--  extern int vorbis_encode_setup_init(vorbis_info *vi);
--
--  /**
--   * This function implements a generic interface to miscellaneous encoder
--   * settings similar to the classic UNIX 'ioctl()' system call.  Applications
--   * may use vorbis_encode_ctl() to query or set bitrate management or quality
--   * mode details by using one of several \e request arguments detailed below.
--   * vorbis_encode_ctl() must be called after one of
--   * vorbis_encode_setup_managed() or vorbis_encode_setup_vbr().  When used
--   * to modify settings, \ref vorbis_encode_ctl() must be called before \ref
--   * vorbis_encode_setup_init().
--   *
--   * \param vi      Pointer to an initialized vorbis_info struct.
--   *
--   * \param number Specifies the desired action; See \ref encctlcodes "the list
--   * of available requests".
--   *
--   * \param arg void * pointing to a data structure matching the request
--   * argument.
--   *
--   * \retval 0          Success. Any further return information (such as the result of a
--   * query) is placed into the storage pointed to by *arg.
--   *
--   * \retval OV_EINVAL  Invalid argument, or an attempt to modify a setting after
--   * calling vorbis_encode_setup_init().
--   *
--   * \retval OV_EIMPL   Unimplemented or unknown request
--   */
--  extern int vorbis_encode_ctl(vorbis_info *vi,int number,void *arg);
--
--  /**
--   * \deprecated This is a deprecated interface. Please use vorbis_encode_ctl()
--   * with the \ref ovectl_ratemanage2_arg struct and \ref
--   * OV_ECTL_RATEMANAGE2_GET and \ref OV_ECTL_RATEMANAGE2_SET calls in new code.
--   *
--   * The \ref ovectl_ratemanage_arg structure is used with vorbis_encode_ctl()
--   * and the \ref OV_ECTL_RATEMANAGE_GET, \ref OV_ECTL_RATEMANAGE_SET, \ref
--   * OV_ECTL_RATEMANAGE_AVG, \ref OV_ECTL_RATEMANAGE_HARD calls in order to
--   * query and modify specifics of the encoder's bitrate management
--   * configuration.
--  */
--  struct ovectl_ratemanage_arg {
--    int    management_active; /**< nonzero if bitrate management is active*/
--  /** hard lower limit (in kilobits per second) below which the stream bitrate
--      will never be allowed for any given bitrate_hard_window seconds of time.*/
--    long   bitrate_hard_min;
--  /** hard upper limit (in kilobits per second) above which the stream bitrate
--      will never be allowed for any given bitrate_hard_window seconds of time.*/
--    long   bitrate_hard_max;
--  /** the window period (in seconds) used to regulate the hard bitrate minimum
--      and maximum*/
--    double bitrate_hard_window;
--  /** soft lower limit (in kilobits per second) below which the average bitrate
--      tracker will start nudging the bitrate higher.*/
--    long   bitrate_av_lo;
--  /** soft upper limit (in kilobits per second) above which the average bitrate
--      tracker will start nudging the bitrate lower.*/
--    long   bitrate_av_hi;
--  /** the window period (in seconds) used to regulate the average bitrate
--      minimum and maximum.*/
--    double bitrate_av_window;
--  /** Regulates the relative centering of the average and hard windows; in
--      libvorbis 1.0 and 1.0.1, the hard window regulation overlapped but
--      followed the average window regulation. In libvorbis 1.1 a bit-reservoir
--      interface replaces the old windowing interface; the older windowing
--      interface is simulated and this field has no effect.*/
--    double bitrate_av_window_center;
--  };
--
--  /**
--   * \name struct ovectl_ratemanage2_arg
--   *
--   * The ovectl_ratemanage2_arg structure is used with vorbis_encode_ctl() and
--   * the OV_ECTL_RATEMANAGE2_GET and OV_ECTL_RATEMANAGE2_SET calls in order to
--   * query and modify specifics of the encoder's bitrate management
--   * configuration.
--   *
--  */
--  struct ovectl_ratemanage2_arg {
--    int    management_active; /**< nonzero if bitrate management is active */
--  /** Lower allowed bitrate limit in kilobits per second */
--    long   bitrate_limit_min_kbps;
--  /** Upper allowed bitrate limit in kilobits per second */
--    long   bitrate_limit_max_kbps;
--    long   bitrate_limit_reservoir_bits; /**<Size of the bitrate reservoir in bits */
--  /** Regulates the bitrate reservoir's preferred fill level in a range from 0.0
--   * to 1.0; 0.0 tries to bank bits to buffer against future bitrate spikes, 1.0
--   * buffers against future sudden drops in instantaneous bitrate. Default is
--   * 0.1
--   */
--    double bitrate_limit_reservoir_bias;
--  /** Average bitrate setting in kilobits per second */
--    long   bitrate_average_kbps;
--  /** Slew rate limit setting for average bitrate adjustment; sets the minimum
--   *  time in seconds the bitrate tracker may swing from one extreme to the
--   *  other when boosting or damping average bitrate.
--   */
--    double bitrate_average_damping;
--  };
--
--
--  /**
--   * \name vorbis_encode_ctl() codes
--   *
--   * \anchor encctlcodes
--   *
--   * These values are passed as the \c number parameter of vorbis_encode_ctl().
--   * The type of the referent of that function's \c arg pointer depends on these
--   * codes.
--   */
--  /*@{*/
--
--  /**
--   * Query the current encoder bitrate management setting.
--   *
--   *Argument: <tt>struct ovectl_ratemanage2_arg *</tt>
--   *
--   * Used to query the current encoder bitrate management setting. Also used to
--   * initialize fields of an ovectl_ratemanage2_arg structure for use with
--   * \ref OV_ECTL_RATEMANAGE2_SET.
--   */
--  #define OV_ECTL_RATEMANAGE2_GET      0x14
--
--  /**
--   * Set the current encoder bitrate management settings.
--   *
--   * Argument: <tt>struct ovectl_ratemanage2_arg *</tt>
--   *
--   * Used to set the current encoder bitrate management settings to the values
--   * listed in the ovectl_ratemanage2_arg. Passing a NULL pointer will disable
--   * bitrate management.
--  */
--  #define OV_ECTL_RATEMANAGE2_SET      0x15
--
--  /**
--   * Returns the current encoder hard-lowpass setting (kHz) in the double
--   * pointed to by arg.
--   *
--   * Argument: <tt>double *</tt>
--  */
--  #define OV_ECTL_LOWPASS_GET          0x20
--
--  /**
--   *  Sets the encoder hard-lowpass to the value (kHz) pointed to by arg. Valid
--   *  lowpass settings range from 2 to 99.
--   *
--   * Argument: <tt>double *</tt>
--  */
--  #define OV_ECTL_LOWPASS_SET          0x21
--
--  /**
--   *  Returns the current encoder impulse block setting in the double pointed
--   *  to by arg.
--   *
--   * Argument: <tt>double *</tt>
--  */
--  #define OV_ECTL_IBLOCK_GET           0x30
--
--  /**
--   *  Sets the impulse block bias to the the value pointed to by arg.
--   *
--   * Argument: <tt>double *</tt>
--   *
--   *  Valid range is -15.0 to 0.0 [default]. A negative impulse block bias will
--   *  direct to encoder to use more bits when incoding short blocks that contain
--   *  strong impulses, thus improving the accuracy of impulse encoding.
--   */
--  #define OV_ECTL_IBLOCK_SET           0x31
--
--  /**
--   *  Returns the current encoder coupling setting in the int pointed
--   *  to by arg.
--   *
--   * Argument: <tt>int *</tt>
--  */
--  #define OV_ECTL_COUPLING_GET         0x40
--
--  /**
--   *  Enables/disables channel coupling in multichannel encoding according to arg.
--   *
--   * Argument: <tt>int *</tt>
--   *
--   *  Zero disables channel coupling for multichannel inputs, nonzer enables
--   *  channel coupling.  Setting has no effect on monophonic encoding or
--   *  multichannel counts that do not offer coupling.  At present, coupling is
--   *  available for stereo and 5.1 encoding.
--   */
--  #define OV_ECTL_COUPLING_SET         0x41
--
--    /* deprecated rate management supported only for compatibility */
--
--  /**
--   * Old interface to querying bitrate management settings.
--   *
--   * Deprecated after move to bit-reservoir style management in 1.1 rendered
--   * this interface partially obsolete.
--
--   * \deprecated Please use \ref OV_ECTL_RATEMANAGE2_GET instead.
--   *
--   * Argument: <tt>struct ovectl_ratemanage_arg *</tt>
--   */
--  #define OV_ECTL_RATEMANAGE_GET       0x10
--  /**
--   * Old interface to modifying bitrate management settings.
--   *
--   *  deprecated after move to bit-reservoir style management in 1.1 rendered
--   *  this interface partially obsolete.
--   *
--   * \deprecated Please use \ref OV_ECTL_RATEMANAGE2_SET instead.
--   *
--   * Argument: <tt>struct ovectl_ratemanage_arg *</tt>
--   */
--  #define OV_ECTL_RATEMANAGE_SET       0x11
--  /**
--   * Old interface to setting average-bitrate encoding mode.
--   *
--   * Deprecated after move to bit-reservoir style management in 1.1 rendered
--   * this interface partially obsolete.
--   *
--   *  \deprecated Please use \ref OV_ECTL_RATEMANAGE2_SET instead.
--   *
--   * Argument: <tt>struct ovectl_ratemanage_arg *</tt>
--   */
--  #define OV_ECTL_RATEMANAGE_AVG       0x12
--  /**
--   * Old interface to setting bounded-bitrate encoding modes.
--   *
--   * deprecated after move to bit-reservoir style management in 1.1 rendered
--   * this interface partially obsolete.
--   *
--   *  \deprecated Please use \ref OV_ECTL_RATEMANAGE2_SET instead.
--   *
--   * Argument: <tt>struct ovectl_ratemanage_arg *</tt>
--   */
--  #define OV_ECTL_RATEMANAGE_HARD      0x13
--
--  /*@}*/
--
--
--
--  #ifdef __cplusplus
--  }
--
--  #ifdef __cplusplus
--  extern "C"
--  {
--  #endif /* __cplusplus */
--
--  #include <stdio.h>
--  #include "codec.h"
--
--  /* The function prototypes for the callbacks are basically the same as for
--   * the stdio functions fread, fseek, fclose, ftell.
--   * The one difference is that the FILE * arguments have been replaced with
--   * a void * - this is to be used as a pointer to whatever internal data these
--   * functions might need. In the stdio case, it's just a FILE * cast to a void *
--   *
--   * If you use other functions, check the docs for these functions and return
--   * the right values. For seek_func(), you *MUST* return -1 if the stream is
--   * unseekable
--   */
--  typedef struct {
--    size_t (*read_func)  (void *ptr, size_t size, size_t nmemb, void *datasource);
--    int    (*seek_func)  (void *datasource, ogg_int64_t offset, int whence);
--    int    (*close_func) (void *datasource);
--    long   (*tell_func)  (void *datasource);
--  } ov_callbacks;
--
--  #ifndef OV_EXCLUDE_STATIC_CALLBACKS
--
--  /* a few sets of convenient callbacks, especially for use under
--   * Windows where ov_open_callbacks() should always be used instead of
--   * ov_open() to avoid problems with incompatible crt.o version linking
--   * issues. */
--
--  static int _ov_header_fseek_wrap(FILE *f,ogg_int64_t off,int whence){
--    if(f==NULL)return(-1);
--
--  #ifdef __MINGW32__
--    return fseeko64(f,off,whence);
--  #elif defined (_WIN32)
--    return _fseeki64(f,off,whence);
--  #else
--    return fseek(f,off,whence);
--  #endif
--  }
--
--  /* These structs below (OV_CALLBACKS_DEFAULT etc) are defined here as
--   * static data. That means that every file which includes this header
--   * will get its own copy of these structs whether it uses them or
--   * not unless it #defines OV_EXCLUDE_STATIC_CALLBACKS.
--   * These static symbols are essential on platforms such as Windows on
--   * which several different versions of stdio support may be linked to
--   * by different DLLs, and we need to be certain we know which one
--   * we're using (the same one as the main application).
--   */
--
--  static ov_callbacks OV_CALLBACKS_DEFAULT = {
--    (size_t (*)(void *, size_t, size_t, void *))  fread,
--    (int (*)(void *, ogg_int64_t, int))           _ov_header_fseek_wrap,
--    (int (*)(void *))                             fclose,
--    (long (*)(void *))                            ftell
--  };
--
--  static ov_callbacks OV_CALLBACKS_NOCLOSE = {
--    (size_t (*)(void *, size_t, size_t, void *))  fread,
--    (int (*)(void *, ogg_int64_t, int))           _ov_header_fseek_wrap,
--    (int (*)(void *))                             NULL,
--    (long (*)(void *))                            ftell
--  };
--
--  static ov_callbacks OV_CALLBACKS_STREAMONLY = {
--    (size_t (*)(void *, size_t, size_t, void *))  fread,
--    (int (*)(void *, ogg_int64_t, int))           NULL,
--    (int (*)(void *))                             fclose,
--    (long (*)(void *))                            NULL
--  };
--
--  static ov_callbacks OV_CALLBACKS_STREAMONLY_NOCLOSE = {
--    (size_t (*)(void *, size_t, size_t, void *))  fread,
--    (int (*)(void *, ogg_int64_t, int))           NULL,
--    (int (*)(void *))                             NULL,
--    (long (*)(void *))                            NULL
--  };
--
--  #endif
--
--  #define  NOTOPEN   0
--  #define  PARTOPEN  1
--  #define  OPENED    2
--  #define  STREAMSET 3
--  #define  INITSET   4
--
--  typedef struct OggVorbis_File {
--    void            *datasource; /* Pointer to a FILE *, etc. */
--    int              seekable;
--    ogg_int64_t      offset;
--    ogg_int64_t      end;
--    ogg_sync_state   oy;
--
--    /* If the FILE handle isn't seekable (eg, a pipe), only the current
--       stream appears */
--    int              links;
--    ogg_int64_t     *offsets;
--    ogg_int64_t     *dataoffsets;
--    long            *serialnos;
--    ogg_int64_t     *pcmlengths; /* overloaded to maintain binary
--                                    compatibility; x2 size, stores both
--                                    beginning and end values */
--    vorbis_info     *vi;
--    vorbis_comment  *vc;
--
--    /* Decoding working state local storage */
--    ogg_int64_t      pcm_offset;
--    int              ready_state;
--    long             current_serialno;
--    int              current_link;
--
--    double           bittrack;
--    double           samptrack;
--
--    ogg_stream_state os; /* take physical pages, weld into a logical
--                            stream of packets */
--    vorbis_dsp_state vd; /* central working state for the packet->PCM decoder */
--    vorbis_block     vb; /* local working space for packet->PCM decode */
--
--    ov_callbacks callbacks;
--
--  } OggVorbis_File;
--
--
--  extern int ov_clear(OggVorbis_File *vf);
--  extern int ov_fopen(const char *path,OggVorbis_File *vf);
--  extern int ov_open(FILE *f,OggVorbis_File *vf,const char *initial,long ibytes);
--  extern int ov_open_callbacks(void *datasource, OggVorbis_File *vf,
--                  const char *initial, long ibytes, ov_callbacks callbacks);
--
--  extern int ov_test(FILE *f,OggVorbis_File *vf,const char *initial,long ibytes);
--  extern int ov_test_callbacks(void *datasource, OggVorbis_File *vf,
--                  const char *initial, long ibytes, ov_callbacks callbacks);
--  extern int ov_test_open(OggVorbis_File *vf);
--
--  extern long ov_bitrate(OggVorbis_File *vf,int i);
--  extern long ov_bitrate_instant(OggVorbis_File *vf);
--  extern long ov_streams(OggVorbis_File *vf);
--  extern long ov_seekable(OggVorbis_File *vf);
--  extern long ov_serialnumber(OggVorbis_File *vf,int i);
--
--  extern ogg_int64_t ov_raw_total(OggVorbis_File *vf,int i);
--  extern ogg_int64_t ov_pcm_total(OggVorbis_File *vf,int i);
--  extern double ov_time_total(OggVorbis_File *vf,int i);
--
--  extern int ov_raw_seek(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_pcm_seek(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_pcm_seek_page(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_time_seek(OggVorbis_File *vf,double pos);
--  extern int ov_time_seek_page(OggVorbis_File *vf,double pos);
--
--  extern int ov_raw_seek_lap(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_pcm_seek_lap(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_pcm_seek_page_lap(OggVorbis_File *vf,ogg_int64_t pos);
--  extern int ov_time_seek_lap(OggVorbis_File *vf,double pos);
--  extern int ov_time_seek_page_lap(OggVorbis_File *vf,double pos);
--
--  extern ogg_int64_t ov_raw_tell(OggVorbis_File *vf);
--  extern ogg_int64_t ov_pcm_tell(OggVorbis_File *vf);
--  extern double ov_time_tell(OggVorbis_File *vf);
--
--  extern vorbis_info *ov_info(OggVorbis_File *vf,int link);
--  extern vorbis_comment *ov_comment(OggVorbis_File *vf,int link);
--
--  extern long ov_read_float(OggVorbis_File *vf,float ***pcm_channels,int samples,
--                            int *bitstream);
--  extern long ov_read_filter(OggVorbis_File *vf,char *buffer,int length,
--                            int bigendianp,int word,int sgned,int *bitstream,
--                            void (*filter)(float **pcm,long channels,long samples,void *filter_param),void *filter_param);
--  extern long ov_read(OggVorbis_File *vf,char *buffer,int length,
--                      int bigendianp,int word,int sgned,int *bitstream);
--  extern int ov_crosslap(OggVorbis_File *vf1,OggVorbis_File *vf2);
--
--  extern int ov_halfrate(OggVorbis_File *vf,int flag);
--  extern int ov_halfrate_p(OggVorbis_File *vf);
--
--  #ifdef __cplusplus
}
