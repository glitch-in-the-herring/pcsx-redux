--lualoader, R"EOF(--
--OpenGL binding, taken and modified from https://github.com/malkia/luajit-opencl

ffi.cdef[[
enum {
 GL_AMBIENT                        = 0x1200,
 GL_DIFFUSE                        = 0x1201,
 GL_SPECULAR                       = 0x1202,
 GL_POSITION                       = 0x1203,
 GL_SPOT_DIRECTION                 = 0x1204,
 GL_SPOT_EXPONENT                  = 0x1205,
 GL_SPOT_CUTOFF                    = 0x1206,
 GL_CONSTANT_ATTENUATION           = 0x1207,
 GL_LINEAR_ATTENUATION             = 0x1208,
 GL_QUADRATIC_ATTENUATION          = 0x1209,
 GL_COMPILE                        = 0x1300,
 GL_COMPILE_AND_EXECUTE            = 0x1301,
 GL_CLEAR                          = 0x1500,
 GL_AND                            = 0x1501,
 GL_AND_REVERSE                    = 0x1502,
 GL_COPY                           = 0x1503,
 GL_AND_INVERTED                   = 0x1504,
 GL_NOOP                           = 0x1505,
 GL_XOR                            = 0x1506,
 GL_OR                             = 0x1507,
 GL_NOR                            = 0x1508,
 GL_EQUIV                          = 0x1509,
 GL_INVERT                         = 0x150A,
 GL_OR_REVERSE                     = 0x150B,
 GL_COPY_INVERTED                  = 0x150C,
 GL_OR_INVERTED                    = 0x150D,
 GL_NAND                           = 0x150E,
 GL_SET                            = 0x150F,
 GL_EMISSION                       = 0x1600,
 GL_SHININESS                      = 0x1601,
 GL_AMBIENT_AND_DIFFUSE            = 0x1602,
 GL_COLOR_INDEXES                  = 0x1603,
 GL_MODELVIEW                      = 0x1700,
 GL_PROJECTION                     = 0x1701,
 GL_TEXTURE                        = 0x1702,
 GL_COLOR                          = 0x1800,
 GL_DEPTH                          = 0x1801,
 GL_STENCIL                        = 0x1802,
 GL_COLOR_INDEX                    = 0x1900,
 GL_STENCIL_INDEX                  = 0x1901,
 GL_DEPTH_COMPONENT                = 0x1902,
 GL_RED                            = 0x1903,
 GL_GREEN                          = 0x1904,
 GL_BLUE                           = 0x1905,
 GL_ALPHA                          = 0x1906,
 GL_RGB                            = 0x1907,
 GL_RGBA                           = 0x1908,
 GL_LUMINANCE                      = 0x1909,
 GL_LUMINANCE_ALPHA                = 0x190A,
 GL_BITMAP                         = 0x1A00,
 GL_POINT                          = 0x1B00,
 GL_LINE                           = 0x1B01,
 GL_FILL                           = 0x1B02,
 GL_RENDER                         = 0x1C00,
 GL_FEEDBACK                       = 0x1C01,
 GL_SELECT                         = 0x1C02,
 GL_FLAT                           = 0x1D00,
 GL_SMOOTH                         = 0x1D01,
 GL_KEEP                           = 0x1E00,
 GL_REPLACE                        = 0x1E01,
 GL_INCR                           = 0x1E02,
 GL_DECR                           = 0x1E03,
 GL_VENDOR                         = 0x1F00,
 GL_RENDERER                       = 0x1F01,
 GL_VERSION                        = 0x1F02,
 GL_EXTENSIONS                     = 0x1F03,
 GL_S                              = 0x2000,
 GL_T                              = 0x2001,
 GL_R                              = 0x2002,
 GL_Q                              = 0x2003,
 GL_MODULATE                       = 0x2100,
 GL_DECAL                          = 0x2101,
 GL_TEXTURE_ENV_MODE               = 0x2200,
 GL_TEXTURE_ENV_COLOR              = 0x2201,
 GL_TEXTURE_ENV                    = 0x2300,
 GL_EYE_LINEAR                     = 0x2400,
 GL_OBJECT_LINEAR                  = 0x2401,
 GL_SPHERE_MAP                     = 0x2402,
 GL_TEXTURE_GEN_MODE               = 0x2500,
 GL_OBJECT_PLANE                   = 0x2501,
 GL_EYE_PLANE                      = 0x2502,
 GL_NEAREST                        = 0x2600,
 GL_LINEAR                         = 0x2601,
 GL_NEAREST_MIPMAP_NEAREST         = 0x2700,
 GL_LINEAR_MIPMAP_NEAREST          = 0x2701,
 GL_NEAREST_MIPMAP_LINEAR          = 0x2702,
 GL_LINEAR_MIPMAP_LINEAR           = 0x2703,
 GL_TEXTURE_MAG_FILTER             = 0x2800,
 GL_TEXTURE_MIN_FILTER             = 0x2801,
 GL_TEXTURE_WRAP_S                 = 0x2802,
 GL_TEXTURE_WRAP_T                 = 0x2803,
 GL_CLAMP                          = 0x2900,
 GL_REPEAT                         = 0x2901,
 GL_CLIENT_PIXEL_STORE_BIT         = 0x00000001,
 GL_CLIENT_VERTEX_ARRAY_BIT        = 0x00000002,
 GL_CLIENT_ALL_ATTRIB_BITS         = 0xffffffff,
 GL_POLYGON_OFFSET_FACTOR          = 0x8038,
 GL_POLYGON_OFFSET_UNITS           = 0x2A00,
 GL_POLYGON_OFFSET_POINT           = 0x2A01,
 GL_POLYGON_OFFSET_LINE            = 0x2A02,
 GL_POLYGON_OFFSET_FILL            = 0x8037,
 GL_ALPHA4                         = 0x803B,
 GL_ALPHA8                         = 0x803C,
 GL_ALPHA12                        = 0x803D,
 GL_ALPHA16                        = 0x803E,
 GL_LUMINANCE4                     = 0x803F,
 GL_LUMINANCE8                     = 0x8040,
 GL_LUMINANCE12                    = 0x8041,
 GL_LUMINANCE16                    = 0x8042,
 GL_LUMINANCE4_ALPHA4              = 0x8043,
 GL_LUMINANCE6_ALPHA2              = 0x8044,
 GL_LUMINANCE8_ALPHA8              = 0x8045,
 GL_LUMINANCE12_ALPHA4             = 0x8046,
 GL_LUMINANCE12_ALPHA12            = 0x8047,
 GL_LUMINANCE16_ALPHA16            = 0x8048,
 GL_INTENSITY                      = 0x8049,
 GL_INTENSITY4                     = 0x804A,
 GL_INTENSITY8                     = 0x804B,
 GL_INTENSITY12                    = 0x804C,
 GL_INTENSITY16                    = 0x804D,
 GL_R3_G3_B2                       = 0x2A10,
 GL_RGB4                           = 0x804F,
 GL_RGB5                           = 0x8050,
 GL_RGB8                           = 0x8051,
 GL_RGB10                          = 0x8052,
 GL_RGB12                          = 0x8053,
 GL_RGB16                          = 0x8054,
 GL_RGBA2                          = 0x8055,
 GL_RGBA4                          = 0x8056,
 GL_RGB5_A1                        = 0x8057,
 GL_RGBA8                          = 0x8058,
 GL_RGB10_A2                       = 0x8059,
 GL_RGBA12                         = 0x805A,
 GL_RGBA16                         = 0x805B,
 GL_TEXTURE_RED_SIZE               = 0x805C,
 GL_TEXTURE_GREEN_SIZE             = 0x805D,
 GL_TEXTURE_BLUE_SIZE              = 0x805E,
 GL_TEXTURE_ALPHA_SIZE             = 0x805F,
 GL_TEXTURE_LUMINANCE_SIZE         = 0x8060,
 GL_TEXTURE_INTENSITY_SIZE         = 0x8061,
 GL_PROXY_TEXTURE_1D               = 0x8063,
 GL_PROXY_TEXTURE_2D               = 0x8064,
 GL_TEXTURE_PRIORITY               = 0x8066,
 GL_TEXTURE_RESIDENT               = 0x8067,
 GL_TEXTURE_BINDING_1D             = 0x8068,
 GL_TEXTURE_BINDING_2D             = 0x8069,
 GL_TEXTURE_BINDING_3D             = 0x806A,
 GL_VERTEX_ARRAY                   = 0x8074,
 GL_NORMAL_ARRAY                   = 0x8075,
 GL_COLOR_ARRAY                    = 0x8076,
 GL_INDEX_ARRAY                    = 0x8077,
 GL_TEXTURE_COORD_ARRAY            = 0x8078,
 GL_EDGE_FLAG_ARRAY                = 0x8079,
 GL_VERTEX_ARRAY_SIZE              = 0x807A,
 GL_VERTEX_ARRAY_TYPE              = 0x807B,
 GL_VERTEX_ARRAY_STRIDE            = 0x807C,
 GL_NORMAL_ARRAY_TYPE              = 0x807E,
 GL_NORMAL_ARRAY_STRIDE            = 0x807F,
 GL_COLOR_ARRAY_SIZE               = 0x8081,
 GL_COLOR_ARRAY_TYPE               = 0x8082,
 GL_COLOR_ARRAY_STRIDE             = 0x8083,
 GL_INDEX_ARRAY_TYPE               = 0x8085,
 GL_INDEX_ARRAY_STRIDE             = 0x8086,
 GL_TEXTURE_COORD_ARRAY_SIZE       = 0x8088,
 GL_TEXTURE_COORD_ARRAY_TYPE       = 0x8089,
 GL_TEXTURE_COORD_ARRAY_STRIDE     = 0x808A,
 GL_EDGE_FLAG_ARRAY_STRIDE         = 0x808C,
 GL_VERTEX_ARRAY_POINTER           = 0x808E,
 GL_NORMAL_ARRAY_POINTER           = 0x808F,
 GL_COLOR_ARRAY_POINTER            = 0x8090,
 GL_INDEX_ARRAY_POINTER            = 0x8091,
 GL_TEXTURE_COORD_ARRAY_POINTER    = 0x8092,
 GL_EDGE_FLAG_ARRAY_POINTER        = 0x8093,
 GL_V2F                            = 0x2A20,
 GL_V3F                            = 0x2A21,
 GL_C4UB_V2F                       = 0x2A22,
 GL_C4UB_V3F                       = 0x2A23,
 GL_C3F_V3F                        = 0x2A24,
 GL_N3F_V3F                        = 0x2A25,
 GL_C4F_N3F_V3F                    = 0x2A26,
 GL_T2F_V3F                        = 0x2A27,
 GL_T4F_V4F                        = 0x2A28,
 GL_T2F_C4UB_V3F                   = 0x2A29,
 GL_T2F_C3F_V3F                    = 0x2A2A,
 GL_T2F_N3F_V3F                    = 0x2A2B,
 GL_T2F_C4F_N3F_V3F                = 0x2A2C,
 GL_T4F_C4F_N3F_V4F                = 0x2A2D,
 GL_BGR                            = 0x80E0,
 GL_BGRA                           = 0x80E1,
 GL_CONSTANT_COLOR                 = 0x8001,
 GL_ONE_MINUS_CONSTANT_COLOR       = 0x8002,
 GL_CONSTANT_ALPHA                 = 0x8003,
 GL_ONE_MINUS_CONSTANT_ALPHA       = 0x8004,
 GL_BLEND_COLOR                    = 0x8005,
 GL_FUNC_ADD                       = 0x8006,
 GL_MIN                            = 0x8007,
 GL_MAX                            = 0x8008,
 GL_BLEND_EQUATION                 = 0x8009,
 GL_BLEND_EQUATION_RGB             = 0x8009,
 GL_BLEND_EQUATION_ALPHA           = 0x883D,
 GL_FUNC_SUBTRACT                  = 0x800A,
 GL_FUNC_REVERSE_SUBTRACT          = 0x800B,
 GL_COLOR_MATRIX                   = 0x80B1,
 GL_COLOR_MATRIX_STACK_DEPTH       = 0x80B2,
 GL_MAX_COLOR_MATRIX_STACK_DEPTH   = 0x80B3,
 GL_POST_COLOR_MATRIX_RED_SCALE    = 0x80B4,
 GL_POST_COLOR_MATRIX_GREEN_SCALE  = 0x80B5,
 GL_POST_COLOR_MATRIX_BLUE_SCALE   = 0x80B6,
 GL_POST_COLOR_MATRIX_ALPHA_SCALE  = 0x80B7,
 GL_POST_COLOR_MATRIX_RED_BIAS     = 0x80B8,
 GL_POST_COLOR_MATRIX_GREEN_BIAS   = 0x80B9,
 GL_POST_COLOR_MATRIX_BLUE_BIAS    = 0x80BA,
 GL_POST_COLOR_MATRIX_ALPHA_BIAS   = 0x80BB,
 GL_COLOR_TABLE                    = 0x80D0,
 GL_POST_CONVOLUTION_COLOR_TABLE   = 0x80D1,
 GL_POST_COLOR_MATRIX_COLOR_TABLE  = 0x80D2,
 GL_PROXY_COLOR_TABLE              = 0x80D3,
 GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = 0x80D4,
 GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = 0x80D5,
 GL_COLOR_TABLE_SCALE              = 0x80D6,
 GL_COLOR_TABLE_BIAS               = 0x80D7,
 GL_COLOR_TABLE_FORMAT             = 0x80D8,
 GL_COLOR_TABLE_WIDTH              = 0x80D9,
 GL_COLOR_TABLE_RED_SIZE           = 0x80DA,
 GL_COLOR_TABLE_GREEN_SIZE         = 0x80DB,
 GL_COLOR_TABLE_BLUE_SIZE          = 0x80DC,
 GL_COLOR_TABLE_ALPHA_SIZE         = 0x80DD,
 GL_COLOR_TABLE_LUMINANCE_SIZE     = 0x80DE,
 GL_COLOR_TABLE_INTENSITY_SIZE     = 0x80DF,
 GL_CONVOLUTION_1D                 = 0x8010,
 GL_CONVOLUTION_2D                 = 0x8011,
 GL_SEPARABLE_2D                   = 0x8012,
 GL_CONVOLUTION_BORDER_MODE        = 0x8013,
 GL_CONVOLUTION_FILTER_SCALE       = 0x8014,
 GL_CONVOLUTION_FILTER_BIAS        = 0x8015,
 GL_REDUCE                         = 0x8016,
 GL_CONVOLUTION_FORMAT             = 0x8017,
 GL_CONVOLUTION_WIDTH              = 0x8018,
 GL_CONVOLUTION_HEIGHT             = 0x8019,
 GL_MAX_CONVOLUTION_WIDTH          = 0x801A,
 GL_MAX_CONVOLUTION_HEIGHT         = 0x801B,
 GL_POST_CONVOLUTION_RED_SCALE     = 0x801C,
 GL_POST_CONVOLUTION_GREEN_SCALE   = 0x801D,
 GL_POST_CONVOLUTION_BLUE_SCALE    = 0x801E,
 GL_POST_CONVOLUTION_ALPHA_SCALE   = 0x801F,
 GL_POST_CONVOLUTION_RED_BIAS      = 0x8020,
 GL_POST_CONVOLUTION_GREEN_BIAS    = 0x8021,
 GL_POST_CONVOLUTION_BLUE_BIAS     = 0x8022,
 GL_POST_CONVOLUTION_ALPHA_BIAS    = 0x8023,
 GL_CONSTANT_BORDER                = 0x8151,
 GL_REPLICATE_BORDER               = 0x8153,
 GL_CONVOLUTION_BORDER_COLOR       = 0x8154,
 GL_MAX_ELEMENTS_VERTICES          = 0x80E8,
 GL_MAX_ELEMENTS_INDICES           = 0x80E9,
 GL_HISTOGRAM                      = 0x8024,
 GL_PROXY_HISTOGRAM                = 0x8025,
 GL_HISTOGRAM_WIDTH                = 0x8026,
 GL_HISTOGRAM_FORMAT               = 0x8027,
 GL_HISTOGRAM_RED_SIZE             = 0x8028,
 GL_HISTOGRAM_GREEN_SIZE           = 0x8029,
 GL_HISTOGRAM_BLUE_SIZE            = 0x802A,
 GL_HISTOGRAM_ALPHA_SIZE           = 0x802B,
 GL_HISTOGRAM_LUMINANCE_SIZE       = 0x802C,
 GL_HISTOGRAM_SINK                 = 0x802D,
 GL_MINMAX                         = 0x802E,
 GL_MINMAX_FORMAT                  = 0x802F,
 GL_MINMAX_SINK                    = 0x8030,
 GL_TABLE_TOO_LARGE                = 0x8031,
 GL_UNSIGNED_BYTE_3_3_2            = 0x8032,
 GL_UNSIGNED_SHORT_4_4_4_4         = 0x8033,
 GL_UNSIGNED_SHORT_5_5_5_1         = 0x8034,
 GL_UNSIGNED_INT_8_8_8_8           = 0x8035,
 GL_UNSIGNED_INT_10_10_10_2        = 0x8036,
 GL_UNSIGNED_BYTE_2_3_3_REV        = 0x8362,
 GL_UNSIGNED_SHORT_5_6_5           = 0x8363,
 GL_UNSIGNED_SHORT_5_6_5_REV       = 0x8364,
 GL_UNSIGNED_SHORT_4_4_4_4_REV     = 0x8365,
 GL_UNSIGNED_SHORT_1_5_5_5_REV     = 0x8366,
 GL_UNSIGNED_INT_8_8_8_8_REV       = 0x8367,
 GL_UNSIGNED_INT_2_10_10_10_REV    = 0x8368,
 GL_RESCALE_NORMAL                 = 0x803A,
 GL_LIGHT_MODEL_COLOR_CONTROL      = 0x81F8,
 GL_SINGLE_COLOR                   = 0x81F9,
 GL_SEPARATE_SPECULAR_COLOR        = 0x81FA,
 GL_PACK_SKIP_IMAGES               = 0x806B,
 GL_PACK_IMAGE_HEIGHT              = 0x806C,
 GL_UNPACK_SKIP_IMAGES             = 0x806D,
 GL_UNPACK_IMAGE_HEIGHT            = 0x806E,
 GL_TEXTURE_3D                     = 0x806F,
 GL_PROXY_TEXTURE_3D               = 0x8070,
 GL_TEXTURE_DEPTH                  = 0x8071,
 GL_TEXTURE_WRAP_R                 = 0x8072,
 GL_MAX_3D_TEXTURE_SIZE            = 0x8073,
 GL_CLAMP_TO_EDGE                  = 0x812F,
 GL_CLAMP_TO_BORDER                = 0x812D,
 GL_TEXTURE_MIN_LOD                = 0x813A,
 GL_TEXTURE_MAX_LOD                = 0x813B,
 GL_TEXTURE_BASE_LEVEL             = 0x813C,
 GL_TEXTURE_MAX_LEVEL              = 0x813D,
 GL_SMOOTH_POINT_SIZE_RANGE        = 0x0B12,
 GL_SMOOTH_POINT_SIZE_GRANULARITY  = 0x0B13,
 GL_SMOOTH_LINE_WIDTH_RANGE        = 0x0B22,
 GL_SMOOTH_LINE_WIDTH_GRANULARITY  = 0x0B23,
 GL_ALIASED_POINT_SIZE_RANGE       = 0x846D,
 GL_ALIASED_LINE_WIDTH_RANGE       = 0x846E,
 GL_TEXTURE0                       = 0x84C0,
 GL_TEXTURE1                       = 0x84C1,
 GL_TEXTURE2                       = 0x84C2,
 GL_TEXTURE3                       = 0x84C3,
 GL_TEXTURE4                       = 0x84C4,
 GL_TEXTURE5                       = 0x84C5,
 GL_TEXTURE6                       = 0x84C6,
 GL_TEXTURE7                       = 0x84C7,
 GL_TEXTURE8                       = 0x84C8,
 GL_TEXTURE9                       = 0x84C9,
 GL_TEXTURE10                      = 0x84CA,
 GL_TEXTURE11                      = 0x84CB,
 GL_TEXTURE12                      = 0x84CC,
 GL_TEXTURE13                      = 0x84CD,
 GL_TEXTURE14                      = 0x84CE,
 GL_TEXTURE15                      = 0x84CF,
 GL_TEXTURE16                      = 0x84D0,
 GL_TEXTURE17                      = 0x84D1,
 GL_TEXTURE18                      = 0x84D2,
 GL_TEXTURE19                      = 0x84D3,
 GL_TEXTURE20                      = 0x84D4,
 GL_TEXTURE21                      = 0x84D5,
 GL_TEXTURE22                      = 0x84D6,
 GL_TEXTURE23                      = 0x84D7,
 GL_TEXTURE24                      = 0x84D8,
 GL_TEXTURE25                      = 0x84D9,
 GL_TEXTURE26                      = 0x84DA,
 GL_TEXTURE27                      = 0x84DB,
 GL_TEXTURE28                      = 0x84DC,
 GL_TEXTURE29                      = 0x84DD,
 GL_TEXTURE30                      = 0x84DE,
 GL_TEXTURE31                      = 0x84DF,
 GL_ACTIVE_TEXTURE                 = 0x84E0,
 GL_CLIENT_ACTIVE_TEXTURE          = 0x84E1,
 GL_MAX_TEXTURE_UNITS              = 0x84E2,
 GL_COMBINE                        = 0x8570,
 GL_COMBINE_RGB                    = 0x8571,
 GL_COMBINE_ALPHA                  = 0x8572,
 GL_RGB_SCALE                      = 0x8573,
 GL_ADD_SIGNED                     = 0x8574,
 GL_INTERPOLATE                    = 0x8575,
 GL_CONSTANT                       = 0x8576,
 GL_PRIMARY_COLOR                  = 0x8577,
 GL_PREVIOUS                       = 0x8578,
 GL_SUBTRACT                       = 0x84E7,
 };
]]

-- )EOF"